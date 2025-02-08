import sys
import base64
import datetime
import json
import re
import requests
import os
from tqdm import tqdm
from Crypto.PublicKey import RSA
from Crypto.Signature import pkcs1_15
from Crypto.Hash import SHA512
change_log_file_name = "CHANGELOG.md"

def extract_latest_changelog(filepath):
    with open(filepath, 'r', encoding='utf-8') as file:
        content = file.read()

    # Регулярное выражение для поиска последней версии и ее изменений
    pattern = r'## \[(\d+\.\d+\.\d+)\] - \d{2}\.\d{2}\.\d{4}\n+((?: - .*\n?)*)'
    match = re.search(pattern, content)

    if match:
        # Извлекаем версию и изменения
        latest_version = match.group(1)
        changes = match.group(2).strip()

        changes = '\n'.join(line.lstrip('- ').strip() for line in changes.splitlines())

        return latest_version, changes
    else:
        return None, None

def generate_signature(key_id, private_key_content):
    # Импортируем закрытый ключ из base64
    private_key = RSA.import_key(base64.b64decode(private_key_content))

    # Создаем временную метку в формате ISO 8601 с точностью до миллисекунд
    timestamp = datetime.datetime.now(datetime.timezone.utc).isoformat(timespec='milliseconds')
    message_to_sign = key_id + timestamp

    # Создаем хэш объекта и подписываем его с помощью закрытого ключа
    hash_obj = SHA512.new(message_to_sign.encode())
    signer = pkcs1_15.new(private_key)
    signature_bytes = signer.sign(hash_obj)
    signature_value = base64.b64encode(signature_bytes).decode()

    return {
        "keyId": key_id,
        "timestamp": timestamp,
        "signature": signature_value
    }

def request_api_token(signature_data):
    url = 'https://public-api.rustore.ru/public/auth'

    headers = {
        'Content-Type': 'application/json'
    }

    data = json.dumps({
        "keyId": signature_data["keyId"],
        "timestamp": signature_data["timestamp"],
        "signature": signature_data["signature"]
    })

    response = requests.post(url, headers=headers, data=data)

    if response.status_code == 200:
        jsonResponse = response.json()
        token = jsonResponse.get('body').get('jwe')
        return token
    else:
        print(f"Failed to get API Token: {response.status_code} {response.text}")
        sys.exit(1)

def get_version_number(package_name, api_key, whatsNew):
    url = f'https://public-api.rustore.ru/public/v1/application/{package_name}/version'

    headers = {
        'Content-Type': 'application/json',
        'Public-Token': api_key
    }

    response = requests.post(url, headers=headers, data=json.dumps({'whatsNew': whatsNew}))

    if response.status_code == 200:
        version_number = response.json().get('body')
        print(f"Version number received: {version_number}")
        return version_number
    else:
        print(f"Failed to get version number: {response.status_code} {response.text}")
        sys.exit(1)

def submit_for_review(package_name, api_key, version_number):
    url = f'https://public-api.rustore.ru/public/v1/application/{package_name}/version/{version_number}/commit'

    headers = {
        'Content-Type': 'application/json',
        'Public-Token': api_key
    }

    response = requests.post(url, headers=headers)

    if response.status_code == 200:
        version_number = response.json().get('body')
        print(f"Черновик отправлен на ревью: {response.text}")
        return version_number
    else:
        print(f"Не удалось отправить черновик на ревью: {response.status_code} {response.text}")
        sys.exit(1)

def upload_aab(package_name, version_number, api_key, aab_file_path):
    url = f"https://public-api.rustore.ru/public/v1/application/{package_name}/version/{version_number}/aab"

    headers = {
        "Public-Token": api_key
    }

    # Получаем размер файла
    file_size = os.path.getsize(aab_file_path)

    with open(aab_file_path, 'rb') as file:
        # Создаем прогресс-бар
        with tqdm(total=file_size, unit='B', unit_scale=True, desc="Uploading") as progress_bar:
            # Обернем файл с tqdm
            wrapped_file = TqdmFile(file, progress_bar)

            files = {
                'file': wrapped_file
            }

            response = requests.post(url, headers=headers, files=files)

    if response.status_code == 200:
        print(f"AAB файл успешно загружен. {response.text}")
    else:
        print(f"Ошибка при загрузке AAB файла: {response.status_code} {response.text}")

class TqdmFile:
    def __init__(self, file, progress_bar):
        self.file = file
        self.progress_bar = progress_bar

    def read(self, size=-1):
        data = self.file.read(size)
        self.progress_bar.update(len(data))
        return data

    def __getattr__(self, attr):
        return getattr(self.file, attr)

def main():
    if len(sys.argv) < 5:
        print("Обязательные параметры: keyId, privateKey, packageName, pathToAabFile")
        print("Пример: python3 rustore-api-key-gen.py 354751 MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQClnpt+5Ndcz/GBz5cXL0Z5u/nowqXWv+KwyQijSLClgar/r1jy2bnTAnvBssTOqQN... ru.mafbase.app build/app/outputs/bundle/release/app-release.aab")
    else:
        key_id = sys.argv[1]
        private_key_content = sys.argv[2]
        package_name = sys.argv[3]
        aab_file_path = sys.argv[4]

        # Генерируем подпись
        signature_data = generate_signature(key_id, private_key_content)

        # Получаем API токен
        api_token = request_api_token(signature_data)

        latest_version, latest_changes = extract_latest_changelog(change_log_file_name)
        print(f'Список изменений для версии {latest_version}:\n{latest_changes}')

        # Получаем номер версии
        version_number = get_version_number(package_name, api_token, latest_changes)

        # Загружаем AAB файл
        upload_aab(package_name, version_number, api_token, aab_file_path)

        # Отправляем на Review
        submit_for_review(package_name, api_token, version_number)

if __name__ == "__main__":
    main()
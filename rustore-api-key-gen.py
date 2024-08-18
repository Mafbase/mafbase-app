import sys
import base64
import datetime
import json
import requests
from Crypto.PublicKey import RSA
from Crypto.Signature import pkcs1_15
from Crypto.Hash import SHA512

def generate_signature(key_id, private_key_content):
    # Импортируем закрытый ключ из base64
    private_key = RSA.import_key(base64.b64decode(private_key_content))

    # Создаем временную метку в формате ISO 8601 с точностью до миллисекунд
    timestamp = datetime.datetime.now(datetime.timezone.utc).isoformat(timespec='milliseconds')
    message_to_sign = key_id + timestamp
    print("Message to sign:", message_to_sign)

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

def get_version_number(package_name, api_key):
    url = f'https://public-api.rustore.ru/public/v1/application/{package_name}/version'

    headers = {
        'Content-Type': 'application/json',
        'Public-Token': api_key
    }

    response = requests.post(url, headers=headers, data=json.dumps({}))

    if response.status_code == 200:
        version_number = response.json().get('body')
        print(f"Version number received: {version_number}")
        return version_number
    else:
        print(f"Failed to get version number: {response.status_code} {response.text}")
        sys.exit(1)

def upload_aab(package_name, version_number, api_key, aab_file_path):
    url = f"https://public-api.rustore.ru/public/v1/application/{package_name}/version/{version_number}/aab"

    headers = {
        "Public-Token": api_key
    }

    with open(aab_file_path, 'rb') as file:
        files = {
            'file': file
        }
        response = requests.post(url, headers=headers, files=files)

    if response.status_code == 200:
        print(f"AAB файл успешно загружен. {response.text}")
    else:
        print(f"Ошибка при загрузке AAB файла: {response.status_code} {response.text}")

def main():
    if len(sys.argv) < 5:
        print("Обязательные параметры: keyId, privateKey, packageName, pathToAabFile")
        print("Пример: python ruStoreUploader.py 354751 MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQClnpt+5Ndcz/GBz5cXL0Z5u/nowqXWv+KwyQijSLClgar/r1jy2bnTAnvBssTOqQN... ru.mafbase.app build/app/outputs/bundle/release/app-release.aab")
    else:
        key_id = sys.argv[1]
        private_key_content = sys.argv[2]
        package_name = sys.argv[3]
        aab_file_path = sys.argv[4]

        # Генерируем подпись
        signature_data = generate_signature(key_id, private_key_content)

        # Получаем API токен
        api_token = request_api_token(signature_data)

        # Получаем номер версии
        version_number = get_version_number(package_name, api_token)

        # Загружаем AAB файл
        upload_aab(package_name, version_number, api_token, aab_file_path)

if __name__ == "__main__":
    main()
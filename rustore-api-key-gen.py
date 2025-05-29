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
from requests_toolbelt import MultipartEncoder, MultipartEncoderMonitor

change_log_file_name = "CHANGELOG.md"

def extract_latest_changelog(filepath):
    with open(filepath, 'r', encoding='utf-8') as file:
        content = file.read()

    pattern = r'## \[(\d+\.\d+\.\d+)\] - \d{2}\.\d{2}\.\d{4}\n+((?:- .*\n?)*)'
    match = re.search(pattern, content)

    if match:
        latest_version = match.group(1)
        changes = match.group(2).strip()
        changes = '\n'.join(line.lstrip('- ').strip() for line in changes.splitlines())
        return latest_version, changes
    else:
        return None, None

def generate_signature(key_id, private_key_content):
    private_key = RSA.import_key(base64.b64decode(private_key_content))
    timestamp = datetime.datetime.now(datetime.timezone.utc).isoformat(timespec='milliseconds')
    message_to_sign = key_id + timestamp

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
    headers = {'Content-Type': 'application/json'}
    data = json.dumps(signature_data)

    response = requests.post(url, headers=headers, data=data)

    if response.status_code == 200:
        return response.json().get('body', {}).get('jwe')
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
        print(f"Черновик отправлен на ревью: {response.text}")
        return response.json().get('body')
    else:
        print(f"Не удалось отправить черновик на ревью: {response.status_code} {response.text}")
        sys.exit(1)

def upload_aab(package_name, version_number, api_key, aab_file_path):
    url = f"https://public-api.rustore.ru/public/v1/application/{package_name}/version/{version_number}/aab"
    headers = {"Public-Token": api_key}
    file_size = os.path.getsize(aab_file_path)

    with open(aab_file_path, 'rb') as file:
        encoder = MultipartEncoder(fields={'file': (os.path.basename(aab_file_path), file, 'application/octet-stream')})

        with tqdm(total=encoder.len, unit='B', unit_scale=True, desc="Uploading", file=sys.stdout) as progress_bar:
            def callback(monitor):
                progress_bar.update(monitor.bytes_read - progress_bar.n)

            monitor = MultipartEncoderMonitor(encoder, callback)
            headers['Content-Type'] = monitor.content_type

            response = requests.post(url, data=monitor, headers=headers)

    if response.status_code == 200:
        print(f"AAB файл успешно загружен. {response.text}")
    else:
        print(f"Ошибка при загрузке AAB файла: {response.status_code} {response.text}")

def main():
    if len(sys.argv) < 5:
        print("Обязательные параметры: keyId, privateKey, packageName, pathToAabFile")
        print("Пример: python3 rustore_uploader.py 354751 <PRIVATE_KEY> ru.mafbase.app path/to/app-release.aab")
        sys.exit(1)

    key_id = sys.argv[1]
    private_key_content = sys.argv[2]
    package_name = sys.argv[3]
    aab_file_path = sys.argv[4]

    signature_data = generate_signature(key_id, private_key_content)
    api_token = request_api_token(signature_data)

    latest_version, latest_changes = extract_latest_changelog(change_log_file_name)
    print(f'Список изменений для версии {latest_version}:\n{latest_changes}')

    version_number = get_version_number(package_name, api_token, latest_changes)
    upload_aab(package_name, version_number, api_token, aab_file_path)

    # Отправляем на Review
    submit_for_review(package_name, api_token, version_number)

if __name__ == "__main__":
    main()

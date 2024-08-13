import sys
import base64
import datetime
import json
from Crypto.PublicKey import RSA
from Crypto.Signature import pkcs1_15
from Crypto.Hash import SHA512

def generate_signature(key_id, private_key_content):
    private_key = RSA.import_key(base64.b64decode(private_key_content))

    timestamp = datetime.datetime.now(datetime.timezone.utc).isoformat(timespec='milliseconds')
    message_to_sign = key_id + timestamp
    print("Message to sign:", message_to_sign)

    hash_obj = SHA512.new(message_to_sign.encode())
    signer = pkcs1_15.new(private_key)
    signature_bytes = signer.sign(hash_obj)
    signature_value = base64.b64encode(signature_bytes).decode()

    return signature_value

def main():
    if len(sys.argv) < 3:
        print("Обязательные параметры: keyId - id ключа, privateKey - приватный ключ\nПример: python ruStoreTokenGenerator.py 354751 MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQClnpt+5Ndcz/GBz5cXL0Z5u/nowqXWv+KwyQijSLClgar/r1jy2bnTAnvBssTOqQN...")
    else:
        key_id = sys.argv[1]
        private_key_content = sys.argv[2]
        print(generate_signature(key_id, private_key_content))

if __name__ == "__main__":
    main()
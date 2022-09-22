flutter pub get
flutter analyze
flutter test
flutter build web --release
cd build
zip client.zip web/ -r
scp -i ~/.ssh/id_rsa -P 2323 client.zip server-runner@mafia-generator.tomsk.ru:~/
rm client.zip
ssh -i ~/.ssh/id_rsa server-runner@mafia-generator.tomsk.ru -p 2323 "./update_client.sh"

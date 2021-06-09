import 'package:encrypt/encrypt.dart' as enc;

String encode(String password) {
  final plainText = password;
  final key = enc.Key.fromUtf8('operatingRoom524');
  final iv = enc.IV.fromUtf8('encryptionIntVec');

  final encrypter = enc.Encrypter(enc.AES(key));
  final encrypted = encrypter.encrypt(plainText, iv: iv);
  print(encrypted.base64);
  return encrypted.base64;
}

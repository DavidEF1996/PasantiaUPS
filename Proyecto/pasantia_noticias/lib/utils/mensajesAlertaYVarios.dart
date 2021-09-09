import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter/material.dart';

String encode(String password) {
  final plainText = password;
  final key = enc.Key.fromUtf8('operatingRoom524');
  final iv = enc.IV.fromUtf8('encryptionIntVec');

  final encrypter = enc.Encrypter(enc.AES(key));
  final encrypted = encrypter.encrypt(plainText, iv: iv);

  return encrypted.base64;
}

void mostrarAlerta(BuildContext context, String titulo, String mensaje) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(titulo),
          ),
          content: Text(mensaje),
          actions: <Widget>[
            Container(
              color: Colors.blue,
              child: FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'OK',
                    style: TextStyle(color: Colors.black),
                  )),
            )
          ],
        );
      });
}

aceptarNegar(BuildContext context, String mensaje, void cargar()) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text('¿Esta seguro que desea insertar esta noticia?'),
          ),
          content: Text(mensaje),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Confirmar',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop('Confirmar');

                cargar();
              },
            ),
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop('Cancelar');
                },
                child: Text(
                  'Cancelar',
                  style: TextStyle(color: Colors.black),
                ))
          ],
        );
      });
}

String decode(String password) {
  final key = enc.Key.fromUtf8('operatingRoom524');
  final iv = enc.IV.fromUtf8('encryptionIntVec');

  final encrypter = enc.Encrypter(enc.AES(key));
  final decrypted = encrypter.decrypt(enc.Encrypted.from64(password), iv: iv);

  return (decrypted);
}

import 'dart:convert';

import 'package:mailer/smtp_server.dart';
import 'package:pasantia_noticias/model/correoModelo.dart';
import 'package:pasantia_noticias/services/Conn.dart';
import 'package:mailer/mailer.dart';
import 'package:http/http.dart' as http;

class CorreoServicio {
  static String correoGlobal;
  static const URL = Conn.URL;
  static const headers = {"Content-type": " application/json"};

  static const String servicio_crear = "/correoElectronico";

  static crearCorreo(Correo correo) async {
    String username = 'noticiaspolitecnicasalesiana@gmail.com';
    String password = 'noticiasups';

    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username)
      ..recipients.add(correo.correo)
      //   ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
      // ..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = correo.asunto
      ..text = correo.cuerpo;

    try {
      final sendReport = await send(message, smtpServer);

      print(sendReport);
    } on MailerException catch (e) {
      for (var p in e.problems) {}
    }
  }

  static Future crearCorreoServidor(json) async {
    print(json);
    final response = await http.post(Uri.parse(URL + servicio_crear),
        body: json, headers: headers, encoding: Encoding.getByName('utf-8'));
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      return response;
    } else {
      return null;
    }
  }
}

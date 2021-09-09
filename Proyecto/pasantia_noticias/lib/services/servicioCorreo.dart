import 'package:mailer/smtp_server.dart';
import 'package:pasantia_noticias/model/correoModelo.dart';
import 'package:pasantia_noticias/services/Conn.dart';
import 'package:mailer/mailer.dart';

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
    } on MailerException catch (e) {
      for (var p in e.problems) {}
    }
  }
}

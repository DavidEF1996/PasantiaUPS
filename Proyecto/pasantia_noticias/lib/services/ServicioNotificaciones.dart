import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pasantia_noticias/services/Conn.dart';

class ServicioNotificaciones {
  static const URL = Conn.URL;

  static const String servicio_notificicacion = "/notificar";

  static const headers = {"Content-type": " application/json"};

  static Future<bool> notificarUsuarios(json) async {
    http.Response response = await http.post(
        Uri.parse(URL + servicio_notificicacion),
        body: json,
        headers: headers,
        encoding: Encoding.getByName("utf-8"));

    if (response.body.contains('true')) {
      return true;
    } else {
      return false;
    }
  }
}

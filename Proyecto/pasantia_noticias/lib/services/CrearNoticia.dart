import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:pasantia_noticias/services/Conn.dart';

class ServiciosNoticias {
  static const String servicio_crear = "/crearNoticia";
  static const String servicio_notificacion = "/notificar";
  static const String servicio_listarNombres = "/listaNoticias";

  static const String URL = Conn.URL;

  static const headers = {'Content-Type': 'application/json'};

  static Future crearNoticia(json) async {
    final response = await http.post(Uri.parse(URL + servicio_crear),
        body: json, headers: headers, encoding: Encoding.getByName('utf-8'));

    if (response.statusCode == 200) {
      return response;
    } else {
      return null;
    }
  }

  static Future<bool> notificarUsuarios(json) async {
    http.Response response = await http.post(
        Uri.parse(URL + servicio_notificacion),
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

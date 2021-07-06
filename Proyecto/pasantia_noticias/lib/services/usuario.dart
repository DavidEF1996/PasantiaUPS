import 'dart:convert';

import 'package:pasantia_noticias/model/modeloUsuario.dart';

import 'package:pasantia_noticias/services/Conn.dart';
import 'package:http/http.dart' as http;

class UsuarioServicio {
  static const String servicio_obtener_Usuario = "/obtenerUsuario";
  static const String IP = Conn.IP;
  static const int PORT = Conn.PORT;
  static const String servicio_crear = "/crear";
  static const String URL = Conn.URL;
  static const headers = {'Content-Type': 'application/json'};
  static Usuario d = new Usuario();

  static Future crearUsuario(json) async {
    http.Response response = await http.post(Uri.parse(URL + servicio_crear),
        body: json, headers: headers, encoding: Encoding.getByName('utf-8'));

    if (response.statusCode == 200) {
      print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
      print(response.body);
      Map<String, dynamic> user = jsonDecode(response.body);
      d.usuario = user['usuario'];
      d.contrasena = user['contrasena'];

      return response;
    } else {
      return null;
    }
  }
}

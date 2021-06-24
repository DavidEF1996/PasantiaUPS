import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pasantia_noticias/services/Conn.dart';

class UserService {
  static var nombreUsuariologueado = "";
  static var apellidoUsuarioLogueado = "";
  static var usuariologueado = "";
  static var nombreCompletoUsuarioLogueado = "";
  static var tipoUsuario = "";
  static const URL = Conn.URL;
  static const String servicio_change = "/changePass";
  static const String servicio_token = "/cambiarToken";

  static const headers = {"Content-type": " application/json"};

  Future loginUsuario(String correo, String contrasena) async {
    //print(correo + ' ' + contrasena);
    final body = {"user": correo, "password": contrasena};
    var body2 = jsonEncode(body);
    final respuesta = await http.post(Uri.parse(URL + "/login"),
        headers: headers, body: body2, encoding: Encoding.getByName('utf-8'));

    if (respuesta.statusCode == 200) {
      final decodedata = json.decode(respuesta.body);
      print(decodedata);
      nombreUsuariologueado = decodedata['nombres'];
      apellidoUsuarioLogueado = decodedata['apellidos'];
      tipoUsuario = decodedata['tipoUsuario'];
      usuariologueado = nombreUsuariologueado.split(" ")[0] +
          " " +
          apellidoUsuarioLogueado.split(" ")[0];

      nombreCompletoUsuarioLogueado =
          nombreUsuariologueado + " " + apellidoUsuarioLogueado;
      return decodedata;
    } else {
      print(respuesta.statusCode);
      return null;
    }
  }

  static Future<bool> changePass(json) async {
    print("llegue al metodo 2 cambiar contra");
    http.Response response = await http.post(Uri.parse(URL + servicio_change),
        body: json, headers: headers, encoding: Encoding.getByName("utf-8"));
    print(response.body);
    if (response.body.contains('true')) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> actualizarToken(json) async {
    http.Response response = await http.post(Uri.parse(URL + servicio_token),
        body: json, headers: headers, encoding: Encoding.getByName("utf-8"));
    print(response.body);
    if (response.body.contains('true')) {
      return true;
    } else {
      return false;
    }
  }
}

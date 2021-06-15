import 'dart:convert';

import 'package:pasantia_noticias/model/NoticiaM.dart';
import 'package:pasantia_noticias/services/Conn.dart';
import 'package:pasantia_noticias/services/api_response.dart';
import 'package:http/http.dart' as http;

class ListaNoticias {
  static const URL = Conn.URL;
  static const String servicio_listarNombres = "/listaNoticias";

  static Future<APIResponse<List<NoticiaM>>> listaNoticias(
      String categoria) async {
    return await http.get(
        Uri.parse(URL + servicio_listarNombres + "/$categoria"),
        headers: {"Content-Type": "application/json"}).then((data) {
      //log('La respuesta obtenida es -----------: ' + data.body);
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        print("-------------");
        print(jsonData);
        print("-------------");
        final doctorL = <NoticiaM>[];
        for (var item in jsonData) {
          doctorL.add(NoticiaM.fromJson(item));
        }
        return APIResponse<List<NoticiaM>>(data: doctorL);
      }
      return APIResponse<List<NoticiaM>>(error: true, mensajeError: "Error");
    }).catchError(
        (_) => APIResponse<List<NoticiaM>>(error: true, mensajeError: "Error"));
  }

  static Future<List<NoticiaM>> getNoticias(String categoria) async {
    final response =
        await http.get(Uri.parse(URL + servicio_listarNombres + '/$categoria'));
    if (response.statusCode == 200) {
      print(response.body);
      return _listaNoticias(response.body).toList();
    } else if (response.statusCode == 404) {
      print(response.statusCode);
      return null;
    } else {
      throw Exception("Error del servidor!!");
    }
  }

  static List<NoticiaM> _listaNoticias(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<NoticiaM>((json) => NoticiaM.fromJson(json)).toList();
  }
}

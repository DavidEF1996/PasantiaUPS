import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';

import 'package:mime_type/mime_type.dart';

import 'package:http/http.dart' as http;
import 'package:pasantia_noticias/services/Conn.dart';

class UrlServicio {
  static const String servicio_crear = "/crearNoticia";
  static const String servicio_notificacion = "/notificar";

  static const String URL = Conn.URL;

  static const headers = {'Content-Type': 'application/json'};

  static Future<String> subirImagen(File imagen) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dgy69al50/image/upload?upload_preset=l9rwflkr');
    final mimeType = mime(imagen.path).split('/'); //image/jpeg

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('file', imagen.path,
        contentType: MediaType(mimeType[0], mimeType[1]));

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      return null;
    }

    final respData = json.decode(resp.body);

    return respData['secure_url'];
  }
}

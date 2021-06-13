import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:pasantia_noticias/services/Conn.dart';

class ServiciosNoticias {
  static const String servicio_crear = "/crearNoticia";

  static const String URL = Conn.URL;

  static const headers = {'Content-Type': 'application/json'};

  static Future crearNoticia(json) async {
    print(json);
    http.Response response = await http.post(Uri.parse(URL + servicio_crear),
        body: json, headers: headers, encoding: Encoding.getByName('utf-8'));
    print(response.statusCode);
    print(response.body);

    return response;
  }

  /*String readTimestamp(int timestamp) {
    var now = new DateTime.now();
    var format = new DateFormat('HH:mm a');
    var date = new DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
    var diff = date.difference(now);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);

      print("----------");
      print("----------");
    } else {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + 'DAY AGO';
      } else {
        time = diff.inDays.toString() + 'DAYS AGO';
      }
    }

    return time;
  }*/
}

// To parse this JSON data, do
//
//     final doctor = doctorFromJson(jsonString);

import 'dart:convert';

DatosNoticia datosFromJson(String str) =>
    DatosNoticia.fromJson(json.decode(str));

String datosToJson(DatosNoticia data) => json.encode(data.toJson());

class DatosNoticia {
  DatosNoticia({this.indice, this.estado, this.cambio});

  int indice;
  bool estado;
  int cambio;

  factory DatosNoticia.fromJson(Map<String, dynamic> json) => DatosNoticia(
      indice: json["indice"], estado: json["estado"], cambio: json["cambio"]);

  Map<String, dynamic> toJson() =>
      {"indice": indice, "estado": estado, "cambio": cambio};
}

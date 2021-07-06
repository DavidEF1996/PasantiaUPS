// To parse this JSON data, do
//
//     final doctor = doctorFromJson(jsonString);

import 'dart:convert';

Correo correoFromJson(String str) => Correo.fromJson(json.decode(str));

String correoToJson(Correo data) => json.encode(data.toJson());

class Correo {
  Correo({
    this.correo,
    this.asunto,
    this.cuerpo,
  });

  String correo;
  String asunto;
  String cuerpo;

  factory Correo.fromJson(Map<String, dynamic> json) => Correo(
        correo: json["correo"],
        asunto: json["asunto"],
        cuerpo: json["cuerpo"],
      );

  Map<String, dynamic> toJson() => {
        "correo": correo,
        "asunto": asunto,
        "cuerpo": cuerpo,
      };
}

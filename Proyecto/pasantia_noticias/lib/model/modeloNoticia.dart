// To parse this JSON data, do
//
//     final doctor = doctorFromJson(jsonString);

import 'dart:convert';

Noticia noticiaFromJson(String str) => Noticia.fromJson(json.decode(str));

String noticiaToJson(Noticia data) => json.encode(data.toJson());

class Noticia {
  Noticia({
    this.fechaNacimiento,
    this.titulo,
    this.contenido,
    this.categoria,
    this.codigoUsuario,
  });

  DateTime fechaNacimiento;
  String titulo;
  String contenido;
  String categoria;
  int codigoUsuario;

  factory Noticia.fromJson(Map<String, dynamic> json) => Noticia(
        fechaNacimiento: DateTime.parse(json["fechaNacimiento"]),
        titulo: json["titulo"],
        contenido: json["contenido"],
        categoria: json["categoria"],
        codigoUsuario: json["codigoUsuario"],
      );

  Map<String, dynamic> toJson() => {
        "fechaNacimiento":
            "${fechaNacimiento.year.toString().padLeft(4, '0')}-${fechaNacimiento.month.toString().padLeft(2, '0')}-${fechaNacimiento.day.toString().padLeft(2, '0')}",
        "titulo": titulo,
        "contenido": contenido,
        "categoria": categoria,
        "codigoUsuario": codigoUsuario,
      };
}

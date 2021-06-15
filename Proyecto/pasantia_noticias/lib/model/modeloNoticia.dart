// To parse this JSON data, do
//
//     final doctor = doctorFromJson(jsonString);

import 'dart:convert';

Noticia noticiaFromJson(String str) => Noticia.fromJson(json.decode(str));

String noticiaToJson(Noticia data) => json.encode(data.toJson());

class Noticia {
  Noticia({
    this.fechaNoticia,
    this.titulo,
    this.contenido,
    this.categoria,
    this.imagen,
    this.codigoUsuario,
  });

  DateTime fechaNoticia;
  String titulo;
  String contenido;
  String categoria;
  String imagen;
  int codigoUsuario;

  factory Noticia.fromJson(Map<String, dynamic> json) => Noticia(
        fechaNoticia: DateTime.parse(json["fechaNoticia"]),
        titulo: json["titulo"],
        contenido: json["contenido"],
        categoria: json["categoria"],
        imagen: json["imagen"],
        codigoUsuario: json["codigoUsuario"],
      );

  Map<String, dynamic> toJson() => {
        "fechaNoticia":
            "${fechaNoticia.year.toString().padLeft(4, '0')}-${fechaNoticia.month.toString().padLeft(2, '0')}-${fechaNoticia.day.toString().padLeft(2, '0')}",
        "titulo": titulo,
        "contenido": contenido,
        "categoria": categoria,
        "imagen": imagen,
        "codigoUsuario": codigoUsuario,
      };
}

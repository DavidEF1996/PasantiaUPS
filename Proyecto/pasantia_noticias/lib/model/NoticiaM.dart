// To parse this JSON data, do
//
//     final doctorModelo = doctorModeloFromJson(jsonString);

import 'dart:convert';

List<NoticiaM> noticiaMFromJson(String str) =>
    List<NoticiaM>.from(json.decode(str).map((x) => NoticiaM.fromJson(x)));

String noticiaMToJson(List<NoticiaM> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NoticiaM {
  NoticiaM(
      {this.fechaNoticia,
      this.tituloNoticia,
      this.contenidoNoticia,
      this.categoriaNoticia,
      this.imagen,
      this.codigoUsuario});

  DateTime fechaNoticia;
  String tituloNoticia;
  String contenidoNoticia;
  String categoriaNoticia;
  String imagen;
  int codigoUsuario;

  factory NoticiaM.fromJson(Map<String, dynamic> json) => NoticiaM(
        fechaNoticia: DateTime.parse(json["fechaNoticia"]),
        tituloNoticia: json["tituloNoticia"],
        contenidoNoticia: json["contenidoNoticia"],
        categoriaNoticia: json["categoriaNoticia"],
        imagen: json["imagen"],
        codigoUsuario: json["codigoUsuario"],
      );

  Map<String, dynamic> toJson() => {
        "fechaNoticia": fechaNoticia,
        "tituloNoticia": tituloNoticia,
        "contenidoNoticia": contenidoNoticia,
        "categoriaNoticia": categoriaNoticia,
        "imagen": imagen,
        "codigoUsuario": codigoUsuario,
      };
}

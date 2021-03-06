// To parse this JSON data, do
//
//     final doctor = doctorFromJson(jsonString);

import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  Usuario({
    this.cedula,
    this.nombres,
    this.apellidos,
    this.fechaNacimiento,
    this.token,
    this.usuario,
    this.contrasena,
    this.tipoUsuario,
    this.correo,
  });

  String cedula;
  String nombres;
  String apellidos;
  DateTime fechaNacimiento;

  String token;
  String usuario;
  String contrasena;
  String tipoUsuario;
  String correo;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        cedula: json["cedula"],
        nombres: json["nombres"],
        apellidos: json["apellidos"],
        fechaNacimiento: DateTime.parse(json["fechaNacimiento"]),
        token: json["token"],
        usuario: json["usuario"],
        contrasena: json["contrasena"],
        tipoUsuario: json["tipoUsuario"],
        correo: json["correo"],
      );

  Map<String, dynamic> toJson() => {
        "cedula": cedula,
        "nombres": nombres,
        "apellidos": apellidos,
        "fechaNacimiento":
            "${fechaNacimiento.year.toString().padLeft(4, '0')}-${fechaNacimiento.month.toString().padLeft(2, '0')}-${fechaNacimiento.day.toString().padLeft(2, '0')}",
        "token": token,
        "usuario": usuario,
        "contrasena": contrasena,
        "tipoUsuario": tipoUsuario,
        "correo": correo,
      };
}

// To parse this JSON data, do
//
//     final doctor = doctorFromJson(jsonString);

import 'dart:convert';

Token tokenFromJson(String str) => Token.fromJson(json.decode(str));

String tokenToJson(Token data) => json.encode(data.toJson());

class Token {
  Token({
    this.codigoUsuario,
    this.token,
  });

  int codigoUsuario;
  String token;

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        codigoUsuario: json["codigoUsuario"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "codigoUsuario": codigoUsuario,
        "token": token,
      };
}

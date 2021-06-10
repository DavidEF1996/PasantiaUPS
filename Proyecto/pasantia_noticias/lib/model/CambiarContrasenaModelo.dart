import 'dart:convert';

Changepass changepassFromJson(String str) =>
    Changepass.fromJson(json.decode(str));

String changepassToJson(Changepass data) => json.encode(data.toJson());

class Changepass {
  Changepass({
    this.codigoUsuario,
    this.password,
  });

  int codigoUsuario;
  String password;

  factory Changepass.fromJson(Map<String, dynamic> json) => Changepass(
        codigoUsuario: json["codigoUsuario"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "codigoUsuario": codigoUsuario,
        "password": password,
      };
}

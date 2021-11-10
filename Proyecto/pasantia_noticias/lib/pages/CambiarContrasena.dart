import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pasantia_noticias/model/CambiarContrasenaModelo.dart';
import 'package:pasantia_noticias/model/correoModelo.dart';
import 'package:pasantia_noticias/pages/login/loginPage.dart';
import 'package:pasantia_noticias/services/LoginService.dart';
import 'package:pasantia_noticias/services/Preferencias.dart';
import 'package:pasantia_noticias/services/servicioCorreo.dart';
import 'package:pasantia_noticias/utils/ValidacionesGlobales.dart';
import 'package:pasantia_noticias/utils/mensajesAlertaYVarios.dart';
import 'package:pasantia_noticias/utils/responsive.dart';

class CambioContrasena extends StatefulWidget {
  final int id;
  CambioContrasena(this.id);

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<CambioContrasena> {
  int _id;
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _id = widget.id;
    super.initState();
  }

  TextEditingController nuevaContrasena = TextEditingController();
  TextEditingController repNuevaContrasena = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.bottomLeft,
        colors: [
          Colors.yellow,
          Colors.white,
        ],
      )),
      child: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Nueva Contraseña',
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 102, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 35),
                  )),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      // color: Color.fromRGBO(18, 69, 122, 0.8),
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.black,
                          offset: new Offset(0.0, 20.0),
                          blurRadius: 20.0,
                        ),
                      ],
                      gradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color.fromRGBO(18, 69, 122, 1),
                          Colors.grey,
                        ],
                      )),
                  child: Column(
                    children: [
                      SizedBox(
                        height: responsive.diagonalPorcentaje(2),
                      ),
                      Container(
                        width: responsive.diagonalPorcentaje(40),
                        color: Colors.white,
                        child: TextField(
                          obscureText: true,
                          controller: nuevaContrasena,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Escriba su nueva contraseña aquí",
                              fillColor: Colors.red),
                        ),
                      ),
                      SizedBox(
                        height: responsive.diagonalPorcentaje(2),
                      ),
                      Container(
                        width: responsive.diagonalPorcentaje(40),
                        color: Colors.white,
                        child: TextField(
                          obscureText: true,
                          controller: repNuevaContrasena,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Repita la contraseña",
                          ),
                          onTap: () {
                            if (nuevaContrasena != repNuevaContrasena) {
                              return "Las contraseñas no coinciden";
                            } else {
                              return "";
                            }
                          },
                        ),
                      ),
                      Container(
                          decoration: BoxDecoration(
                              // color: Color.fromRGBO(255, 186, 0, 0.85),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(color: Colors.black26, blurRadius: 5)
                              ]),
                          height: responsive.diagonalPorcentaje(6),
                          width: responsive.diagonalPorcentaje(20),
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: RaisedButton(
                            textColor: Colors.black,
                            color: Color.fromRGBO(255, 186, 0, 0.85),
                            child: Text(
                              'Enviar',
                              style: TextStyle(
                                  fontSize: responsive.diagonalPorcentaje(2),
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              enviar(context, _id, repNuevaContrasena.text);
                            },
                          )),
                      Container(
                          decoration: BoxDecoration(
                              // color: Color.fromRGBO(255, 186, 0, 0.85),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(color: Colors.black26, blurRadius: 5)
                              ]),
                          height: responsive.diagonalPorcentaje(6),
                          width: responsive.diagonalPorcentaje(20),
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: RaisedButton(
                            textColor: Colors.black,
                            color: Colors.brown[400],
                            child: Text(
                              'Cancelar',
                              style: TextStyle(
                                  fontSize: responsive.diagonalPorcentaje(2),
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              final route =
                                  MaterialPageRoute(builder: (context) {
                                return LoginPage();
                              });
                              Navigator.pushReplacement(context, route);
                            },
                          )),
                      SizedBox(
                        height: responsive.diagonalPorcentaje(2),
                      ),
                    ],
                  )),
            ],
          )),
    ));
  }

  Future enviar(BuildContext context, int id, String pass) async {
    if (nuevaContrasena.text != repNuevaContrasena.text) {
      mostrarAlerta(context, "Las contraseñas no coinciden", "");
    } else if (nuevaContrasena.text == "" && repNuevaContrasena.text == "" ||
        nuevaContrasena.text == "" ||
        repNuevaContrasena.text == "") {
      mostrarAlerta(context, "LLene los campos por favor!", "");
    } else if (nuevaContrasena.text == repNuevaContrasena.text) {
      Changepass c = Changepass();
      c.codigoUsuario = id;

      c.password = encode(pass);
      final resultado = await UserService.changePass(jsonEncode(c.toJson()));

      // String valor = resultado;

      if (resultado) {
        mostrarAlerta(context, "Cambio de contraseña exitoso",
            "Ahora puede loguearse usando su nueva contraseña");

        Correo correo = Correo();
        correo.correo = ValidacionesGlobales.correoEnviar;
        correo.asunto = "Contraseña actualizada";
        correo.cuerpo = "Su nueva contraseña es: ${pass.toString()}";
        //final result =
        //  await CorreoServicio.crearCorreo(jsonEncode(correo.toJson()));
        final result = await CorreoServicio.crearCorreo(correo);
        final _preferences = new Preferences();
        _preferences.id = id.toString();

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) {
          return new LoginPage();
        }), (Route<dynamic> route) => false);
      } else {
        mostrarAlerta(
            context, "Error al actualizar contraseña", "Vuelva a intentarlo");
      }
    }
  }
}

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pasantia_noticias/model/cambiarTokenModelo.dart';

import 'package:pasantia_noticias/pages/CambiarContrasena.dart';
import 'package:pasantia_noticias/pages/CrearCuenta.dart';
import 'package:pasantia_noticias/pages/login/widgets/PrincipalGenerales.dart';
import 'package:pasantia_noticias/utils/mensajesAlertaYVarios.dart';
import 'package:pasantia_noticias/services/FireBaseNotificaciones.dart';
import 'package:pasantia_noticias/services/LoginService.dart';
import 'package:pasantia_noticias/services/Preferencias.dart';
import 'package:pasantia_noticias/utils/responsive.dart';
import 'package:pasantia_noticias/widgets/botonReusable.dart';
import 'package:pasantia_noticias/widgets/inputpassword.dart';
import 'package:pasantia_noticias/widgets/inputs_formulario.dart';
import 'package:pasantia_noticias/utils/mensajesAlertaYVarios.dart' as utl;

class LoginForm extends StatefulWidget {
  final String usuario;
  final String contrasena;

  const LoginForm({Key key, this.usuario = "", this.contrasena = ""})
      : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

UserService servicioLogin = new UserService();
String user;
String password;

class _LoginFormState extends State<LoginForm> {
  @override
  void initState() {
    super.initState();
    print(user);
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Container(
      padding: EdgeInsets.all(responsive.diagonalPorcentaje(2)),
      width: MediaQuery.of(context).size.width - 60,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: responsive.diagonalPorcentaje(2),
          ),
          InputTextFormulario(
            iconosPath: 'assets/usuario.svg',
            placeHolder: 'Correo Institucional o Usuario',
            validator: (text) {
              user = text;
              return text.trim().length > 0;
            },
            usuario: widget.usuario,
          ),
          SizedBox(
            height: responsive.diagonalPorcentaje(4),
          ),
          InputPassword(
            iconosPath: 'assets/candado.svg',
            placeHolder: 'Contraseña',
            validator: (text) {
              password = text;
              return text.trim().length > 0;
            },
            usuario: widget.contrasena,
          ),
          SizedBox(
            height: responsive.diagonalPorcentaje(7),
          ),
          BotonReusable(
              onPressed: () {
                iniciarSesion2();
              },
              label: "Iniciar Sesión"),
          SizedBox(
            height: responsive.diagonalPorcentaje(2),
          ),
          FlatButton(
            textColor: Colors.white,
            child: Text(
              'Crear cuenta',
              style: TextStyle(fontSize: responsive.diagonalPorcentaje(2.5)),
            ),
            onPressed: () {
              final route = MaterialPageRoute(builder: (context) {
                return CrearCuenta();
              });
              Navigator.push(context, route);
            },
          )
        ],
      ),
    );
  }

  Future<void> iniciarSesion() async {
    final String usuario =
        utf8.decode(latin1.encode(user), allowMalformed: true);
    setState(() {});
    final String contrasena = password;
    var passwordController;
    final result =
        await servicioLogin.loginUsuario(usuario, utl.encode(contrasena));

    if (result == null) {
      mostrarAlerta(context, "!Error¡", "Error al iniciar el servidor");
    } else {
      ///if (result['acceso']) {
      if (result['bandera'] == 0) {
        final route = MaterialPageRoute(builder: (context) {
          return CambioContrasena(result['codigoUsuario']);
        });
        Navigator.push(context, route);
      } else {
        final _preferences = new Preferences();

        _preferences.id = result['codigoUsuario'].toString();
        _preferences.nombres = UserService.usuariologueado;
        Token token = Token();
        token.codigoUsuario = int.parse(_preferences.id);
        token.token = PushNotificationService.token;
        await servicioLogin.actualizarToken(jsonEncode(token.toJson()));

        final route = MaterialPageRoute(builder: (context) {
          return PrincipalNo();
        });
        Navigator.push(context, route);
      }
      // } else {
      // mostrarAlerta(context, "Error de usuario");
      //  }
    }
  }

  Future<void> iniciarSesion2() async {
    final String usuario =
        utf8.decode(latin1.encode(user), allowMalformed: true);
    final String contrasena = password;
    var passwordController;
    final result =
        await servicioLogin.loginUsuario2(usuario, utl.encode(contrasena));

    if (result != null) {
      if (decode(result['contrasena']) == password) {
        if (result['bandera'] == 0) {
          final route = MaterialPageRoute(builder: (context) {
            return CambioContrasena(result['codigoUsuario']);
          });
          Navigator.push(context, route);
        } else {
          final _preferences = new Preferences();

          _preferences.id = result['codigoUsuario'].toString();
          _preferences.nombres = UserService.usuariologueado;
          _preferences.roles = result['tipoUsuario'];
          Token token = Token();
          token.codigoUsuario = int.parse(_preferences.id);
          token.token = PushNotificationService.token;
          await servicioLogin.actualizarToken(jsonEncode(token.toJson()));

          // final route = MaterialPageRoute(builder: (context) {
          //   return PrincipalNo();
          //  });
          //  Navigator.push(context, route);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) {
            return new PrincipalNo();
          }), (Route<dynamic> route) => false);
        }
      } else {
        mostrarAlerta(context, "¡ERROR!", "La contraseña no es válida");
      }
    } else {
      mostrarAlerta(context, "!ERROR¡", "El usuario no existe");
    }
  }
}

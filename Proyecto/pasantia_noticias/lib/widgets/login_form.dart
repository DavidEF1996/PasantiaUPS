import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pasantia_noticias/model/cambiarTokenModelo.dart';
import 'package:pasantia_noticias/pages/CambiarContrasena.dart';
import 'package:pasantia_noticias/pages/CrearCuenta.dart';
import 'package:pasantia_noticias/pages/login/widgets/PrincipalGenerales.dart';
import 'package:pasantia_noticias/pages/login/widgets/PrincipalNoticias.dart';
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
    print("------------------------------------" + widget.usuario);
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Container(
      width: 330,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InputTextFormulario(
            iconosPath: 'assets/usuario.svg',
            placeHolder: 'Nombre de Usuario',
            validator: (text) {
              user = text;
              return text.trim().length > 0;
            },
            usuario: widget.usuario,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          InputPassword(
            iconosPath: 'assets/contrasena.svg',
            placeHolder: 'Contraseña',
            validator: (text) {
              password = text;
              return text.trim().length > 0;
            },
            usuario: widget.contrasena,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          BotonReusable(
              onPressed: () {
                print(user);
                print(password);
                iniciarSesion();
              },
              label: "Iniciar Sesión"),
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
    final String usuario = user;
    final String contrasena = password;
    var passwordController;
    final result =
        await servicioLogin.loginUsuario(usuario, utl.encode(contrasena));

    // String codigoUsuario = result['codigoUsuario'];

    //print("El codigo de Usuario es: " + result['codigoUsuario']);

    if (result == null) {
      //mostrarAlerta(context, "Error para acceder al servidor!");
    } else {
      if (result['acceso']) {
        if (result['bandera'] == 0) {
          final route = MaterialPageRoute(builder: (context) {
            return CambioContrasena(result['codigoUsuario']);
          });
          Navigator.push(context, route);
        } else {
          final _preferences = new Preferences();
          //print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbbbbbbbbbb' + result);
          _preferences.id = result['codigoUsuario'];
          _preferences.nombres = UserService.usuariologueado;
          Token token = Token();
          token.codigoUsuario = _preferences.id;
          token.token = PushNotificationService.token;
          print("/////////////////");
          print(token.codigoUsuario);
          print(token.token);
          print("/////////////////");
          await servicioLogin.actualizarToken(jsonEncode(token.toJson()));

          final route = MaterialPageRoute(builder: (context) {
            return PrincipalNo();
          });
          Navigator.push(context, route);
        }
      } else {
        // mostrarAlerta(context, "Error de usuario");
      }
    }
  }
}

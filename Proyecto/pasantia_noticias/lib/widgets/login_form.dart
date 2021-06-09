import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pasantia_noticias/pages/CrearCuenta.dart';
import 'package:pasantia_noticias/pages/login/widgets/ListNotices.dart';
import 'package:pasantia_noticias/pages/login/widgets/PrincipalNoticias.dart';
import 'package:pasantia_noticias/utils/responsive.dart';
import 'package:pasantia_noticias/widgets/botonReusable.dart';
import 'package:pasantia_noticias/widgets/inputs_formulario.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key key}) : super(key: key);

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
              return text.trim().length > 0;
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          InputTextFormulario(
            iconosPath: 'assets/contrasena.svg',
            placeHolder: 'Contraseña',
            validator: (text) {
              return text.trim().length > 0;
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          BotonReusable(
              onPressed: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => new PrincipalNoticias(),
                  ),
                );
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
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pasantia_noticias/widgets/botonReusable.dart';
import 'package:pasantia_noticias/widgets/inputs_formulario.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InputTextFormulario(
              iconosPath: 'assets/usuario.svg', placeHolder: 'Usuario'),
          SizedBox(
            height: 20,
          ),
          InputTextFormulario(
              iconosPath: 'assets/contrasena.svg', placeHolder: 'Contraseña'),
          SizedBox(
            height: 20,
          ),
         BotonReusable(onPressed: (){}, label: "Comenzar"),
          SizedBox(height: 200),
        ],
      ),
    );
  }
}

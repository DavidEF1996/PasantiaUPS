import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pasantia_noticias/model/modeloUsuario.dart';
import 'package:pasantia_noticias/services/usuario.dart';
import 'package:pasantia_noticias/utils/credencialesAleatorias.dart';
import 'package:pasantia_noticias/utils/mensajesAlertaYVarios.dart';
import 'package:pasantia_noticias/widgets/botonReusable.dart';
import 'package:pasantia_noticias/widgets/inputs_formulario.dart';
import 'package:pasantia_noticias/widgets/login_form.dart';

class CambiarContrasena extends StatefulWidget {
  @override
  _CambiarContrasenaState createState() => _CambiarContrasenaState();
}

String usuario;
String contrasena;
String cedula;

class _CambiarContrasenaState extends State<CambiarContrasena> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Cambiar Contraseña"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end:
                Alignment(0.7, 0), // 10% of the width, so there are ten blinds.
            colors: [
              const Color.fromRGBO(28, 26, 24, 1),
              const Color.fromRGBO(28, 26, 24, 1),
            ], // red to yellow
            tileMode: TileMode.repeated, // repeats the gradient over the canvas
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color.fromRGBO(101, 91, 80, 0.7),
                ),
                padding: EdgeInsets.all(19),
                child: Column(
                  children: [
                    InputTextFormulario(
                      iconosPath: 'assets/escritura.svg',
                      placeHolder: 'Usuario',
                      validator: (text) {
                        usuario = text;
                        return text.trim().length > 0;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    InputTextFormulario(
                      iconosPath: 'assets/escritura.svg',
                      placeHolder: 'Contraseña',
                      validator: (text) {
                        contrasena = text;
                        return text.trim().length > 0;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    BotonReusable(
                        onPressed: () async {}, label: "Iniciar Sesión"),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  int age = 0;
  int months = 0;
  DateTime currentDate = DateTime.now();
  Future<String> selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1930),
        lastDate: DateTime(2100));

    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
    return currentDate.toString();
  }
}

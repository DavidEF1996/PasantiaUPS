import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pasantia_noticias/model/modeloUsuario.dart';
import 'package:pasantia_noticias/pages/CambiarContrasena.dart';
import 'package:pasantia_noticias/pages/login/loginPage.dart';
import 'package:pasantia_noticias/services/FireBaseNotificaciones.dart';
import 'package:pasantia_noticias/services/usuario.dart';
import 'package:pasantia_noticias/utils/credencialesAleatorias.dart';
import 'package:pasantia_noticias/utils/mensajesAlertaYVarios.dart';
import 'package:pasantia_noticias/widgets/botonReusable.dart';
import 'package:pasantia_noticias/widgets/inputs_formulario.dart';
import 'package:pasantia_noticias/widgets/login_form.dart';

import 'CambiarContrasena.dart';

class CrearCuenta extends StatefulWidget {
  @override
  _CrearCuentaState createState() => _CrearCuentaState();
}

String nombres;
String apellidos;
String cedula;

class _CrearCuentaState extends State<CrearCuenta> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Registrar Usuario"),
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
                      placeHolder: 'Cédula',
                      validator: (text) {
                        cedula = text;
                        return text.trim().length > 0;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    InputTextFormulario(
                      iconosPath: 'assets/escritura.svg',
                      placeHolder: 'Nombres',
                      validator: (text) {
                        nombres = text;
                        return text.trim().length > 0;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    InputTextFormulario(
                      iconosPath: 'assets/escritura.svg',
                      placeHolder: 'Apellidos',
                      validator: (text) {
                        apellidos = text;
                        return text.trim().length > 0;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 226, 199, 1)),
                      child: Column(children: <Widget>[
                        Container(
                            child: Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(" Fecha de Nacimiento:   "),
                            Text(currentDate.year.toString() +
                                "/" +
                                currentDate.month.toString() +
                                "/" +
                                currentDate.day.toString()),
                            IconButton(
                              onPressed: () => selectDate(context),
                              icon: Icon(Icons.date_range),
                              iconSize: 30,
                            ),
                          ],
                        )),

                        // Text("Edad: "+ ),
                      ]),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    InputTextFormulario(
                      iconosPath: 'assets/usuario.svg',
                      placeHolder: 'Tipo Usuario',
                      validator: (text) {
                        return text.trim().length > 0;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    BotonReusable(
                        onPressed: () async {
                          Usuario recibir = save();
                          print("-------------");
                          print(recibir.cedula);
                          print(recibir.nombres);
                          print(recibir.apellidos);
                          print(recibir.fechaNacimiento);

                          //  print(recibir.codigoUsuario);
                          print(recibir.token);
                          print(recibir.usuario);
                          print(recibir.contrasena);
                          print(recibir.tipoUsuario);
                          String decodePassword = recibir.contrasena;
                          await UsuarioServicio.crearUsuario(
                              jsonEncode(recibir.toJson()));
                          final String outputUser = utf8.decode(
                              latin1.encode(recibir.usuario),
                              allowMalformed: true);

                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => LoginPage(
                                        usuario: outputUser,
                                        contrasena: decode(decodePassword),
                                      )));
                        },
                        label: "Iniciar Sesión"),
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

  Usuario save() {
    List<String> credenciales = generateUser(nombres, apellidos);
    Usuario d = new Usuario();
    d.cedula = cedula;
    d.nombres = nombres;
    d.apellidos = apellidos;
    d.fechaNacimiento = currentDate;
    d.token = PushNotificationService.token;
    d.usuario = credenciales[0];
    d.contrasena = encode(credenciales[1]);
    d.tipoUsuario = "usuarios";
    print(credenciales[0]);
    print(apellidos);
    return d;
  }
}

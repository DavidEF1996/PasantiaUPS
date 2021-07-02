import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pasantia_noticias/model/modeloUsuario.dart';
import 'package:pasantia_noticias/pages/CambiarContrasena.dart';
import 'package:pasantia_noticias/pages/login/loginPage.dart';
import 'package:pasantia_noticias/services/FireBaseNotificaciones.dart';
import 'package:pasantia_noticias/services/usuario.dart';
import 'package:pasantia_noticias/utils/credencialesAleatorias.dart';
import 'package:pasantia_noticias/utils/mensajesAlertaYVarios.dart';
import 'package:pasantia_noticias/utils/responsive.dart';
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
String correo;

class _CrearCuentaState extends State<CrearCuenta> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Scaffold(
      appBar: new AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Container(
          alignment: Alignment.bottomLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.yellow,
                Colors.white,
              ],
            )),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: Text(
                    "Llene los campos porfavor:",
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 102, 1),
                        fontSize: responsive.diagonalPorcentaje(5)),
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Container(
                          width: responsive.diagonalPorcentaje(45),
                          height: responsive.diagonalPorcentaje(50),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(18, 69, 122, 0.8),
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
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
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
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
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
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              InputTextFormulario(
                                iconosPath: 'assets/escritura.svg',
                                placeHolder: 'Correo Institucional',
                                validator: (text) {
                                  correo = text;
                                  return text.trim().length > 0;
                                },
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(255, 255, 255, 1)),
                                child: Column(children: <Widget>[
                                  Container(
                                      child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  IconButton(
                                                    icon: Icon(
                                                      Icons.line_style,
                                                      size: 35,
                                                    ),
                                                  ),
                                                ],
                                              )),
                                              Text("  Fecha de Nacimiento:   ",
                                                  style: TextStyle(
                                                      fontFamily: 'sans',
                                                      color: Colors.black,
                                                      fontSize: 16)),
                                              IconButton(
                                                onPressed: () =>
                                                    selectDate(context),
                                                icon: Icon(Icons.date_range),
                                                iconSize: 30,
                                              ),
                                            ],
                                          ),
                                          Text(
                                              'Su fecha de nacimiento es: ' +
                                                  currentDate.year.toString() +
                                                  "/" +
                                                  currentDate.month.toString() +
                                                  "/" +
                                                  currentDate.day.toString(),
                                              style: TextStyle(
                                                  fontFamily: 'sans',
                                                  color: Colors.black,
                                                  fontSize: 16)),
                                        ],
                                      )
                                    ],
                                  )),

                                  // Text("Edad: "+ ),
                                ]),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
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

                                    /*Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) => LoginPage(
                                            usuario: outputUser,
                                            contrasena: decode(decodePassword),
                                          )));*/

                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) {
                                      return new LoginPage(
                                        usuario: outputUser,
                                        contrasena: decode(decodePassword),
                                      );
                                    }), (Route<dynamic> route) => false);
                                  },
                                  label: "Crear"),
                            ],
                          ))
                    ],
                  ),
                ),
              ],
            )),
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

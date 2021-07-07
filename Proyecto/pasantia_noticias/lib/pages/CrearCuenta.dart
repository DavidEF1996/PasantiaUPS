import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pasantia_noticias/model/correoModelo.dart';
import 'package:pasantia_noticias/model/modeloUsuario.dart';
import 'package:pasantia_noticias/pages/CambiarContrasena.dart';
import 'package:pasantia_noticias/pages/login/loginPage.dart';
import 'package:pasantia_noticias/services/FireBaseNotificaciones.dart';
import 'package:pasantia_noticias/services/servicioCorreo.dart';
import 'package:pasantia_noticias/services/usuario.dart';
import 'package:pasantia_noticias/utils/ValidacionesGlobales.dart';
import 'package:pasantia_noticias/utils/credencialesAleatorias.dart';
import 'package:pasantia_noticias/utils/mensajesAlertaYVarios.dart';
import 'package:pasantia_noticias/utils/responsive.dart';
import 'package:pasantia_noticias/validations/apellidos.dart';
import 'package:pasantia_noticias/validations/cedula.dart';
import 'package:pasantia_noticias/validations/correo.dart';
import 'package:pasantia_noticias/validations/nombres.dart';
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
  bool isButtonClickable;
  @override
  void initState() {
    super.initState();
    isButtonClickable = true;
  }

  void ocultarBoton() {
    setState(() {
      isButtonClickable = false;
      print("Clicked Once");
    });
  }

  void mostrarBoton() {
    setState(() {
      isButtonClickable = true;
      print("Clicked Once");
    });
  }

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
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Container(
              padding: EdgeInsets.all(4),
              alignment: Alignment.center,
              child: Text(
                "Llene los campos porfavor:",
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 102, 1),
                    fontSize: responsive.diagonalPorcentaje(4)),
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
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(18, 69, 122, 0.8),
                    ),
                    padding: EdgeInsets.all(19),
                    child: Column(
                      children: [
                        InputTextCedula(
                          iconosPath: 'assets/escritura.svg',
                          placeHolder: 'Cédula',
                          validator: (text) {
                            cedula = text;

                            return text.trim().length == 10;
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        InputTextNomApe(
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
                        InputTextApe(
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
                        InputTextCorreo(
                          iconosPath: 'assets/escritura.svg',
                          placeHolder: 'Correo Electrónico',
                          validator: (text) {
                            correo = text;
                            return text.trim().length > 0;
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
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
                                          onPressed: () => selectDate(context),
                                          icon: Icon(Icons.date_range),
                                          iconSize: 30,
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(
                                          responsive.diagonalPorcentaje(1)),
                                      alignment: Alignment.centerRight,
                                      child: RichText(
                                          text: TextSpan(
                                              text:
                                                  "Su fecha de nacimiento es: ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'sans'),
                                              children: <TextSpan>[
                                            TextSpan(
                                                text: currentDate.year
                                                        .toString() +
                                                    "/" +
                                                    currentDate.month
                                                        .toString() +
                                                    "/" +
                                                    currentDate.day.toString(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: responsive
                                                      .diagonalPorcentaje(2.5),
                                                  fontFamily: 'sans',
                                                ))
                                          ])),
                                    ),
                                    /* Text(
                                        'Su fecha de nacimiento es: ' +
                                            currentDate.year.toString() +
                                            "/" +
                                            currentDate.month.toString() +
                                            "/" +
                                            currentDate.day.toString(),
                                        style: TextStyle(
                                            fontFamily: 'sans',
                                            color: Colors.black,
                                            fontSize: 16)),*/
                                  ],
                                )
                              ],
                            )),

                            // Text("Edad: "+ ),
                          ]),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        Visibility(
                          visible: isButtonClickable,
                          child: BotonReusable(
                              onPressed: () async {
                                if (isButtonClickable) {
                                  ocultarBoton();
                                  if (cedula != "" &&
                                      nombres != "" &&
                                      apellidos != "" &&
                                      correo != "" &&
                                      ValidacionesGlobales.validacionCedula !=
                                          false &&
                                      ValidacionesGlobales.validarNombre !=
                                          false &&
                                      ValidacionesGlobales.validarApellido !=
                                          false &&
                                      ValidacionesGlobales.validacionCorreo !=
                                          false) {
                                    if (currentDate.day != DateTime.now().day) {
                                      ocultarBoton();
                                      mostrarAlerta(
                                          context,
                                          "Espere mientras se crea su cuenta",
                                          "");
                                      Usuario recibir = save();

                                      String decodePassword =
                                          recibir.contrasena;
                                      final result2 =
                                          await UsuarioServicio.crearUsuario(
                                              jsonEncode(recibir.toJson()));
                                      final String outputUser = utf8.decode(
                                          latin1.encode(recibir.usuario),
                                          allowMalformed: true);
                                      if (result2 != null) {
                                        print("llegue");
                                        Correo correo = Correo();
                                        ValidacionesGlobales.correoEnviar =
                                            recibir.correo;
                                        correo.correo = recibir.correo;
                                        correo.asunto =
                                            "Bienvenido, estos son los datos Iniciales de su Cuenta";
                                        correo.cuerpo =
                                            "Su usuario es ${recibir.usuario} y su contraseña es ${recibir.contrasena}";
                                        final result =
                                            await CorreoServicio.crearCorreo(
                                                jsonEncode(correo.toJson()));
                                        CorreoServicio.correoGlobal =
                                            recibir.correo;

                                        mostrarAlerta(
                                            context,
                                            "Se ha creado su cuenta",
                                            "Su usuario y contraseña a sido enviado a su correo");
                                        print(
                                            "ENVIEEEEEEEEEEEEEEEEEEEEE EL CORREOOOOOOOOOOO");
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(builder:
                                                    (BuildContext context) {
                                          return new LoginPage(
                                            usuario: outputUser,
                                            contrasena: decode(decodePassword),
                                          );
                                        }), (Route<dynamic> route) => false);
                                        print("LLEGUEEEEEEEEEEEEEEEE A LOGIN");
                                      } else {
                                        print("SALIOOOOOOOOOOOOO MALLLLL");
                                        mostrarAlerta(
                                            context,
                                            "Algo a salido mal",
                                            "Repita el proceso o espere un tiempo");
                                      }
                                    } else {
                                      mostrarAlerta(context,
                                          "Revise la fecha insertada", "");

                                      mostrarBoton();
                                    }
                                  } else {
                                    print("llego");
                                    mostrarAlerta(
                                        context,
                                        "Los campos deben estar llenos y con el visto verde",
                                        "");
                                    mostrarBoton();
                                  }
                                }
                              },
                              label: "Crear Cuenta"),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )),
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
    d.correo = correo;
    print(credenciales[0]);
    print(apellidos);
    return d;
  }
}

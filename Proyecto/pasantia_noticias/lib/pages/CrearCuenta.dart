import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pasantia_noticias/model/correoModelo.dart';
import 'package:pasantia_noticias/model/modeloUsuario.dart';
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
    isButtonClickable = true;
  }

  void ocultarBoton() {
    setState(() {
      isButtonClickable = false;
    });
  }

  void mostrarBoton() {
    setState(() {
      isButtonClickable = true;
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.00005,
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Llene los campos por favor:",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(0, 0, 102, 1),
                        fontSize: responsive.diagonalPorcentaje(4)),
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Container(
                      width: responsive.diagonalPorcentaje(45),
                      height: responsive.diagonalPorcentaje(90),
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
                      padding: EdgeInsets.all(19),
                      child: Column(
                        children: [
                          InputTextCedula(
                            iconosPath: 'assets/cedula.svg',
                            placeHolder: 'C??dula',
                            validator: (text) {
                              cedula = text;

                              return text.trim().length == 10;
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          InputTextNomApe(
                            iconosPath: 'assets/escribir.svg',
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
                            iconosPath: 'assets/escribir.svg',
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
                            iconosPath: 'assets/email.svg',
                            placeHolder: 'Correo Electr??nico',
                            validator: (text) {
                              correo = text;
                              return text.trim().length > 0;
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
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
                                                    Icons.rule,
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
                                                        currentDate.day
                                                            .toString(),
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: responsive
                                                          .diagonalPorcentaje(
                                                              2.5),
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
                                      if (currentDate != DateTime.now()) {
                                        ocultarBoton();

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
                                          Correo correo = Correo();
                                          ValidacionesGlobales.correoEnviar =
                                              recibir.correo;
                                          correo.correo = recibir.correo;
                                          correo.asunto =
                                              "Bienvenido, estos son los datos Iniciales de su Cuenta";

                                          correo.cuerpo =
                                              "Su usuario es ${recibir.usuario} y su contrase??a es ${recibir.contrasena}";
                                          /* final result =
                                              await CorreoServicio.crearCorreoServidor(
                                                  jsonEncode(correo.toJson()));*/
                                          final result =
                                              await CorreoServicio.crearCorreo(
                                                  correo);
                                          CorreoServicio.correoGlobal =
                                              recibir.correo;

                                          mostrarAlerta(
                                              context,
                                              "Se ha creado su cuenta",
                                              "Su usuario y contrase??a a sido enviado a su correo");

                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(builder:
                                                      (BuildContext context) {
                                            return new LoginPage(
                                              usuario: outputUser,
                                              contrasena:
                                                  decode(decodePassword),
                                            );
                                          }), (Route<dynamic> route) => false);
                                        } else {
                                          mostrarAlerta(
                                              context,
                                              "Algo a salido mal",
                                              "Este usuario ya existe o hubo un problema en el servidor");
                                          mostrarBoton();
                                        }
                                      } else {
                                        mostrarAlerta(context,
                                            "Revise la fecha insertada", "");

                                        mostrarBoton();
                                      }
                                    } else {
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
      lastDate: DateTime(2100),
      //  locale: const Locale("es", "EC"),
      locale: const Locale("es", "ES"),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
              //Background color

              ),
          child: child,
        );
      },
    );

    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
    return currentDate.toString();
  }

  Usuario save() {
    List<String> credenciales = generateUser(nombres, apellidos);
    Usuario d = new Usuario();

    d.cedula = cedula.trim();
    d.nombres = nombres.trim();
    d.apellidos = apellidos.trim();
    d.fechaNacimiento = currentDate;
    d.token = PushNotificationService.token;
    d.usuario = credenciales[0];
    d.contrasena = encode(credenciales[1]);
    d.tipoUsuario = "usuarios";
    d.correo = correo.trim();

    return d;
  }
}

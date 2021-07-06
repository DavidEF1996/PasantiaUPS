import 'dart:convert';
import 'dart:core';

import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:io' as Io;
import 'package:image_picker/image_picker.dart';
import 'package:pasantia_noticias/model/modeloNoticia.dart';
import 'package:pasantia_noticias/pages/login/widgets/PrincipalGenerales.dart';
import 'package:pasantia_noticias/pages/login/widgets/PrincipalNoticias.dart';
import 'package:pasantia_noticias/pages/login/widgets/notices.dart';
import 'package:pasantia_noticias/services/Preferencias.dart';
import 'package:pasantia_noticias/services/URLService.dart';
import 'package:pasantia_noticias/services/crearNoticia.dart';
import 'package:pasantia_noticias/utils/mensajesAlertaYVarios.dart';
import 'package:pasantia_noticias/utils/responsive.dart';
import 'package:pasantia_noticias/widgets/botonRegresar.dart';
import 'package:pasantia_noticias/widgets/botonReusable.dart';
import 'package:pasantia_noticias/widgets/cabecera.dart';

class Administracion extends StatefulWidget {
  @override
  AdministracionState createState() => AdministracionState();
}

File foto;
String base64Image;
TextEditingController titulo = new TextEditingController();
TextEditingController contenido = new TextEditingController();
TextEditingController enlaces = new TextEditingController();
List<Noticias> noticias = Noticias.noticias_album();
final _preferences = new Preferences();
List<int> imageBytes;
int limite = 250;
String mostrarlimite = "250";
var file;
Widget image;
List<dynamic> recibir = [];

class AdministracionState extends State<Administracion> {
  bool status = true;
  int _value = 1;
  disableButton() {
    setState(() {
      status = false;
    });
  }

  enableButton() {
    setState(() {
      status = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Container(
      child: Scaffold(
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
//Decoracion principal

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    BotonRegresar(
                        onPressed: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (context) => new PrincipalNo(),
                            ),
                          );
                        },
                        label: "Regresar"),
                    SizedBox(width: responsive.diagonalPorcentaje(4.5)),
                    Text(
                      "Registro de" + "\n" + "Información",
                      style: TextStyle(
                          fontSize: responsive.diagonalPorcentaje(4),
                          color: Color.fromRGBO(19, 70, 123, 1),
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(responsive.diagonalPorcentaje(2)),
                      width: MediaQuery.of(context).size.width * 0.9,
                      color: Colors.grey,
                      child: DropdownButton(
                          value: _value,
                          items: [
                            DropdownMenuItem(
                              child: Text("Seleccione"),
                              value: 0,
                            ),
                            DropdownMenuItem(
                              child: Text("Urgente"),
                              value: 1,
                            ),
                            DropdownMenuItem(
                              child: Text("Noticias"),
                              value: 2,
                            ),
                            DropdownMenuItem(
                              child: Text("Ofertas Laborales"),
                              value: 3,
                            ),
                            DropdownMenuItem(
                              child: Text("Ofertas de Cursos"),
                              value: 4,
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _value = value;
                            });
                          }),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.width * 0.9,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: imagenSinFoto(),
                    ),
                    Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Seleccione imagen: "),
                        IconButton(
                            icon: Icon(Icons.photo_size_select_actual),
                            onPressed: buscarImagen),
                      ],
                    )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: EdgeInsets.all(responsive.diagonalPorcentaje(2)),
                      color: Colors.grey,
                      child: Column(
                        children: [
                          Text(
                            "Título",
                            style: TextStyle(
                                fontSize: responsive.diagonalPorcentaje(4),
                                color: Color.fromRGBO(28, 26, 24, 1),
                                fontWeight: FontWeight.bold),
                          ),
                          TextField(
                            cursorColor: Colors.black,
                            controller: titulo,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: image,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: EdgeInsets.all(responsive.diagonalPorcentaje(2)),
                      color: Colors.grey,
                      child: Column(
                        children: [
                          Text(
                            "Contenido",
                            style: TextStyle(
                                fontSize: responsive.diagonalPorcentaje(4),
                                color: Color.fromRGBO(28, 26, 24, 1),
                                fontWeight: FontWeight.bold),
                          ),
                          TextField(
                            onChanged: (value) {
                              setState(() {
                                if (limite < 0) {
                                  // mostrarlimite =
                                  //   "No puede tener mas de 250 caracteres";
                                } else {
                                  mostrarlimite = limite.toString();
                                }
                                limite = limite - 1;
                              });
                            },
                            cursorColor: Colors.black,
                            controller: contenido,
                            maxLength: 250,
                            minLines: 1,
                            maxLines: 10,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                counterText:
                                    'Le quedan: ${mostrarlimite} caracteres'),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: EdgeInsets.all(responsive.diagonalPorcentaje(2)),
                      color: Colors.grey,
                      child: Column(
                        children: [
                          Text(
                            "Opcional: ",
                            style: TextStyle(
                                fontSize: responsive.diagonalPorcentaje(4),
                                color: Color.fromRGBO(28, 26, 24, 1),
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Agregue un enlace",
                            style: TextStyle(
                                fontSize: responsive.diagonalPorcentaje(2.2),
                                color: Color.fromRGBO(28, 26, 24, 1),
                                fontWeight: FontWeight.bold),
                          ),
                          TextField(
                            cursorColor: Colors.black,
                            controller: enlaces,
                            decoration:
                                InputDecoration(border: OutlineInputBorder()),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(responsive.diagonalPorcentaje(2)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          BotonReusable(
                              onPressed: () {
                                String categoria;
                                if (_value == 0) {
                                  categoria = "";
                                } else if (_value == 1) {
                                  // print("Noticias");
                                  categoria = "emergencias";
                                } else if (_value == 2) {
                                  categoria = "noticias";
                                  // print("Estado de solicitudes");
                                } else if (_value == 3) {
                                  categoria = "ofertasLaborales";
                                } else if (_value == 4) {
                                  categoria = "ofertasCursos";
                                }

                                if (categoria != "" &&
                                    foto != null &&
                                    titulo.text != "" &&
                                    contenido.text != "") {
                                  print("tengo datos");
                                  save(categoria);
                                } else {
                                  mostrarAlerta(
                                      context,
                                      "Revise la Información",
                                      "Debe llenar todos los campos, solo el de enlaces es opcional");
                                }
                                //
                              },
                              label: "Guardar"),
                          BotonReusable(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                    builder: (context) => new PrincipalNo(),
                                  ),
                                );
                              },
                              label: "Cancelar")
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Noticia noticia = Noticia();
  save(String categoria) async {
    DateTime fechaNotica = DateTime.now();
    noticia.fechaNoticia = fechaNotica;
    noticia.titulo = titulo.text;
    noticia.contenido = contenido.text;
    noticia.imagen = await UrlServicio.subirImagen(foto);
    noticia.categoria = categoria;
    noticia.enlaces = enlaces.text;
    String guardarCodigo = _preferences.id.toString();

    noticia.codigoUsuario = int.parse(guardarCodigo);

    aceptarNegar(context, "¿Desea Continua?", cargar);
  }

  Future<void> cargar() async {
    mostrarAlerta(context, "Espere porfavor...", "Se esta enviando la noticia");
    final result =
        await ServiciosNoticias.crearNoticia(jsonEncode(noticia.toJson()));

    if (result != null) {
      mostrarAlerta(
          context, "¡Proceso Exitoso!", "La noticia fue insertada con éxito");

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) {
        return new PrincipalNo();
      }), (Route<dynamic> route) => false);
    } else {
      mostrarAlerta(context, "¡Error!", "No se pudo insertar correctamente");
    }
  }

  _mostrarFoto() {
    Noticia noticia = Noticia();
    if (noticia.contenido != "abc") {
      return Container();
    } else {
      return Image(
        image: AssetImage(foto?.path ?? 'assets/no-image.png'),
        height: 300.0,
        width: 300,
        fit: BoxFit.cover,
      );
    }
  }

  buscarImagen() async {
    foto = await ImagePicker.pickImage(source: ImageSource.gallery);
    //imprimir();

    if (foto != null) {}
    setState(() {});
  }

  imagenSinFoto() {
    return Image(
      // image: AssetImage(foto?.path ?? 'assets/no-image.png'),
      image: foto != null ? FileImage(foto) : AssetImage('assets/no-image.png'),
      height: 300.0,
      width: 300,
      fit: BoxFit.cover,
    );
  }

  mostrarfotodecodificada() {
    return Image(
      // image: AssetImage(foto?.path ?? 'assets/no-image.png'),
      image: AssetImage(file),
      height: 300.0,
      width: 300,
      fit: BoxFit.cover,
    );
  }

  imprimir() {
    print(foto);
    List<int> imageBytes = foto.readAsBytesSync();
    print(imageBytes);
    base64Image = base64Encode(imageBytes);

    print("convertida en base 64--------------------------");
    print(base64Image);
    recibir[0] = base64Image;
    print("------------------------------------------------");

    final _byteImage = Base64Decoder().convert(base64Image);
    image = Image.memory(_byteImage);

    print("reconstruida -------------------------");
    print(base64Image);
    print("------------------------------------------------");
  }
}

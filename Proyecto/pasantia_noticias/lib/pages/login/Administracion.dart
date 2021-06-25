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
import 'package:pasantia_noticias/services/ServicioListarNoticias.dart';
import 'package:pasantia_noticias/services/ServicioNotificaciones.dart';
import 'package:pasantia_noticias/services/URLService.dart';
import 'package:pasantia_noticias/services/crearNoticia.dart';
import 'package:pasantia_noticias/utils/responsive.dart';
import 'package:pasantia_noticias/widgets/botonRegresar.dart';
import 'package:pasantia_noticias/widgets/botonReusable.dart';

class Administracion extends StatefulWidget {
  @override
  AdministracionState createState() => AdministracionState();
}

File foto;
String base64Image;
TextEditingController titulo = new TextEditingController();
TextEditingController contenido = new TextEditingController();
List<Noticias> noticias = Noticias.noticias_album();
final _preferences = new Preferences();
List<int> imageBytes;
var file;
Widget image;
List<dynamic> recibir = [];

class AdministracionState extends State<Administracion> {
  int _value = 1;

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Container(
      child: Scaffold(
        appBar: new AppBar(
          automaticallyImplyLeading: false,
          title: Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Usuario:")],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
//Decoracion principal
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment(
                    0.7, 0), // 10% of the width, so there are ten blinds.
                colors: [
                  const Color.fromRGBO(28, 26, 24, 1),
                  const Color.fromRGBO(28, 26, 24, 1),
                ], // red to yellow
                tileMode:
                    TileMode.repeated, // repeats the gradient over the canvas
              ),
            ),

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
                          color: Color.fromRGBO(255, 226, 199, 1),
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(responsive.diagonalPorcentaje(2)),
                      width: MediaQuery.of(context).size.width * 0.9,
                      color: Color.fromRGBO(255, 226, 199, 1),
                      child: DropdownButton(
                          value: _value,
                          items: [
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
                      child: imagenSinFoto(),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    IconButton(
                        icon: Icon(Icons.photo_size_select_actual),
                        onPressed: buscarImagen),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: EdgeInsets.all(responsive.diagonalPorcentaje(2)),
                      color: Color.fromRGBO(255, 226, 199, 1),
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
                      color: Color.fromRGBO(255, 226, 199, 1),
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
                            controller: contenido,
                            minLines: 1,
                            maxLines: 5,
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
                                if (_value == 1) {
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
                                /* print("----------------------------------");
                                //print("La fecha es: " + fechaNotica.toString());
                                print("El título es:" + titulo.text);
                                print("El contenido es" + contenido.text);
                                print("La categoria es: " + categoria);
                                print("El codigo de usuario es: " +
                                    _preferences.id.toString());
                                print("----------------------------------");*/

                                save(categoria);

                                //agregarNoticia();
                              },
                              label: "Guardar"),
                          BotonReusable(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                    builder: (context) =>
                                        new PrincipalNoticias(),
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

  save(String categoria) async {
    Noticia noticia = Noticia();

    DateTime fechaNotica = DateTime.now();
    noticia.fechaNoticia = fechaNotica;
    noticia.titulo = titulo.text;
    noticia.contenido = contenido.text;
    noticia.imagen = await UrlServicio.subirImagen(foto);
    noticia.categoria = categoria;
    String guardarCodigo = _preferences.id.toString();
    print("El codigo de usuario es: " + guardarCodigo);
    noticia.codigoUsuario = int.parse(guardarCodigo);
    await ServiciosNoticias.crearNoticia(jsonEncode(noticia.toJson()));
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => PrincipalNo()),
        (Route<dynamic> route) => false);
    //await ServicioNotificaciones.notificarUsuarios(
    //  jsonEncode(noticia.toJson()));
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

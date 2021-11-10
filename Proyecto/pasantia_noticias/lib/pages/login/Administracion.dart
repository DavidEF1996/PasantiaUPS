import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pasantia_noticias/model/modeloNoticia.dart';
import 'package:pasantia_noticias/pages/login/widgets/PrincipalGenerales.dart';

import 'package:pasantia_noticias/services/Preferencias.dart';
import 'package:pasantia_noticias/services/URLService.dart';
import 'package:pasantia_noticias/services/crearNoticia.dart';
import 'package:pasantia_noticias/utils/mensajesAlertaYVarios.dart';
import 'package:pasantia_noticias/utils/responsive.dart';
import 'package:pasantia_noticias/widgets/botonRegresar.dart';
import 'package:pasantia_noticias/widgets/botonReusable.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

class Administracion extends StatefulWidget {
  @override
  AdministracionState createState() => AdministracionState();
}

File foto;
String base64Image;
TextEditingController titulo = new TextEditingController();
TextEditingController contenido = new TextEditingController();
TextEditingController enlaces = new TextEditingController();
final _preferences = new Preferences();
List<int> imageBytes;
int limite;
int contador;
String mostrarlimite;
var file;
Widget image;
List<dynamic> recibir = [];

class AdministracionState extends State<Administracion> {
  bool status = true;
  int _value = 0;
  bool isButtonClickable;
  @override
  void initState() {
    super.initState();
    titulo.text = "";
    contenido.text = "";
    enlaces.text = "";
    foto = null;
    isButtonClickable = true;
    limite = 2000;
    contador = 1;
    mostrarlimite = "2000";
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
                          hint: Text("Seleccione"),
                          value: _value,
                          items: [
                            DropdownMenuItem(
                              child: Text(
                                "Seleccione",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
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
                                if (value.length == contador) {
                                  if (limite < 0) {
                                    // mostrarlimite =
                                    //   "No puede tener mas de 250 caracteres";
                                  } else {
                                    limite = limite - 1;
                                    contador = contador + 1;
                                    mostrarlimite = limite.toString();
                                  }
                                } else if (value.length < contador) {
                                  if (limite < 0) {
                                    // mostrarlimite =
                                    //   "No puede tener mas de 250 caracteres";
                                  } else {
                                    limite = limite + 1;
                                    contador = contador - 1;
                                    mostrarlimite = limite.toString();
                                  }
                                }
                              });
                            },
                            cursorColor: Colors.black,
                            controller: contenido,
                            maxLength: 2000,
                            minLines: 1,
                            maxLines: 100,
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
                    Visibility(
                      visible: isButtonClickable,
                      child: Container(
                        padding:
                            EdgeInsets.all(responsive.diagonalPorcentaje(2)),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              BotonReusable(
                                  onPressed: () {
                                    if (isButtonClickable) {
                                      String categoria;
                                      if (_value == 0) {
                                        categoria = "";
                                      } else if (_value == 1) {
                                        categoria = "emergencias";
                                      } else if (_value == 2) {
                                        categoria = "noticias";
                                      } else if (_value == 3) {
                                        categoria = "ofertasLaborales";
                                      } else if (_value == 4) {
                                        categoria = "ofertasCursos";
                                      }

                                      if (categoria != "" &&
                                          titulo.text != "" &&
                                          contenido.text != "") {
                                        if (foto == null) {
                                          aceptarNegar2(
                                              context,
                                              "¿Desea usar la Imagen Por defecto?",
                                              imagenPorDefecto);
                                        } else if (foto != null) {
                                          save(categoria);
                                        }
                                      } else {
                                        mostrarBoton();
                                        mostrarAlerta(
                                            context,
                                            "Revise la Información",
                                            "Debe llenar todos los campos, solo el de enlaces es opcional");
                                      }
                                    }

                                    //
                                  },
                                  label: "Guardar"),
                              SizedBox(
                                width: responsive.diagonalPorcentaje(1),
                              ),
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
                        ),
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

    aceptarNegar(context, "¿Desea Continuar?", cargar);
  }

  Future<void> cargar() async {
    ocultarBoton();
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
      mostrarBoton();
    }
  }

  Future<void> imagenPorDefecto() async {
    foto = await getImageFileFromAssets('imagen.png');
    print(foto);
    if (foto != null) {}
    setState(() {});
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

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
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
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pasantia_noticias/model/modeloNoticia.dart';
import 'package:pasantia_noticias/pages/login/widgets/PrincipalNoticias.dart';
import 'package:pasantia_noticias/pages/login/widgets/notices.dart';
import 'package:pasantia_noticias/services/Preferencias.dart';
import 'package:pasantia_noticias/services/crearNoticia.dart';
import 'package:pasantia_noticias/utils/responsive.dart';
import 'package:pasantia_noticias/widgets/botonRegresar.dart';
import 'package:pasantia_noticias/widgets/botonReusable.dart';
import 'package:pasantia_noticias/widgets/inputs_formulario.dart';

class Administracion extends StatefulWidget {
  @override
  _AdministracionState createState() => _AdministracionState();
}

TextEditingController titulo = new TextEditingController();
TextEditingController contenido = new TextEditingController();
List<Noticias> noticias = Noticias.noticias_album();
final _preferences = new Preferences();
DateTime fechaNotica = DateTime.now();

class _AdministracionState extends State<Administracion> {
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
                              builder: (context) => new PrincipalNoticias(),
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
                              child: Text("Noticias"),
                              value: 1,
                            ),
                            DropdownMenuItem(
                              child: Text("Estado de Solicitudes"),
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
                      //child: Image.asset("#"),
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.4,
                      color: Colors.grey,
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
                                  categoria = "noticias";
                                } else if (_value == 2) {
                                  categoria = "estadosolicitudes";
                                  // print("Estado de solicitudes");
                                }
                                print("----------------------------------");
                                print("La fecha es: " + fechaNotica.toString());
                                print("El título es:" + titulo.text);
                                print("El contenido es" + contenido.text);
                                print("La categoria es: " + categoria);
                                print("El codigo de usuario es: " +
                                    _preferences.id.toString());
                                print("----------------------------------");

                                save(categoria);

                                List<Noticias> agregarNoticia() {
                                  Noticias(
                                      "Ejemplo de funcionamiento",
                                      "Producto informático para el Programa de Asesoramiento Empresarial",
                                      "Nam sodales elementum dolor non semper. Donec ac risus risus. Proin lacus nulla, bibendum aliquam nibh vel, viverra aliquam arcu. Ut eu tempus tellus. Maecenas euismod bibendum nisi, eget mollis urna sagittis sed. Duis molestie, metus ac facilisis pretium, urna nulla varius nisi, in volutpat tellus justo a neque. Sed ac mi dui. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Sed lacus dui, laoreet in urna eu, tristique lobortis odio. Donec dignissim erat metus, a molestie lorem vulputate eget. Sed vulputate dignissim purus, ut varius libero elementum at. Curabitur quis diam dui. Nullam a venenatis urna.",
                                      Colors.black,
                                      "assets/titulacion.jpg",
                                      "11/05/2021");
                                }

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
    noticia.fechaNacimiento = fechaNotica;
    noticia.titulo = titulo.text;
    noticia.contenido = contenido.text;
    noticia.categoria = categoria;
    String guardarCodigo = _preferences.id.toString();
    noticia.codigoUsuario = int.parse(guardarCodigo);
    await ServiciosNoticias.crearNoticia(jsonEncode(noticia.toJson()));
  }
}

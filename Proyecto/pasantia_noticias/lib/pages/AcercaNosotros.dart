import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pasantia_noticias/model/NoticiaM.dart';
import 'package:pasantia_noticias/pages/login/MenuLateral.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';

import 'package:pasantia_noticias/utils/responsive.dart';

class AcercaNosotros extends StatefulWidget {
  AcercaNosotros({
    Key key,
  }) : super(key: key);

  @override
  _AcercaNosotrosState createState() => _AcercaNosotrosState();
}

class _AcercaNosotrosState extends State<AcercaNosotros> {
  @override
  void initState() {
    super.initState();
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
              children: [
                //  Cabecera(),
                Text(" "),
                //usuariologueado.botonSalir(context),
              ],
            ),
          ),
        ),
        drawer: MenuLateral(),
        body:
            //Container()
            SingleChildScrollView(
          child:
              //  Container(child: ,)
              Container(
            color: Colors.white,
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(responsive.diagonalPorcentaje(0)),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          image: DecorationImage(
                            image: AssetImage('assets/universidad.jpg'),
                            fit: BoxFit.fitWidth,
                            //  colorFilter: new ColorFilter.mode(
                            //    Colors.black.withOpacity(1), BlendMode.dstATop),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: responsive.diagonalPorcentaje(21),
                      ),
                      SizedBox(
                        height: responsive.diagonalPorcentaje(2),
                      ),
                      Container(
                          // color: Colors.red ,
                          width: MediaQuery.of(context).size.width - 30,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                // alignment: Main.center,
                                child: Text(
                                  "Nosotros",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize:
                                          responsive.diagonalPorcentaje(3.7),
                                      color: Color.fromRGBO(19, 70, 123, 1),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: responsive.diagonalPorcentaje(1.5),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 50,
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        text: utf8.decode(latin1.encode(''),
                                            allowMalformed: true),
                                        style: TextStyle(
                                            fontSize: responsive
                                                .diagonalPorcentaje(3),
                                            color:
                                                Color.fromRGBO(19, 70, 123, 1),
                                            fontWeight: FontWeight.bold),
                                        children: <TextSpan>[
                                          // TextSpan(text: " " + "\n"),
                                          TextSpan(
                                              text: ('Noticias Computación UPS, es creada ante la constante necesidad de mantener informada a la comunidad universitaria sobre los  acontecimientos que se presentan diariamente. De esta manera se presenta una herramienta digital cuyo fin radica en brindar información clara y oportuna sobre las distintas actividades y eventos que se desarrollan en la carrera , tanto para estudiantes, como personal docente.' +
                                                  '\n' +
                                                  'A futuro, esperamos que la aplicación pueda extenderse a las otras carreras de tal modo que todos se beneficien de los servicios de esta app.'),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'sans',
                                                  fontSize: responsive
                                                      .diagonalPorcentaje(
                                                          1.5))),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: responsive.diagonalPorcentaje(2),
                              ),
                              Container(
                                  child: Text(
                                "Créditos",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize:
                                        responsive.diagonalPorcentaje(3.5),
                                    color: Color.fromRGBO(19, 70, 123, 1),
                                    fontWeight: FontWeight.bold),
                              )),
                              SizedBox(
                                height: responsive.diagonalPorcentaje(1),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width - 50,
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text: utf8.decode(latin1.encode(''),
                                        allowMalformed: true),
                                    style: TextStyle(
                                        fontSize:
                                            responsive.diagonalPorcentaje(3),
                                        color: Color.fromRGBO(19, 70, 123, 1),
                                        fontWeight: FontWeight.bold),
                                    children: <TextSpan>[
                                      // TextSpan(text: " " + "\n"),
                                      TextSpan(
                                          text:
                                              ('IDEA INICIAL Y DIRECTOR DE PROYECTO '),
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  19, 70, 123, 1),
                                              fontFamily: 'sans',
                                              fontSize: responsive
                                                  .diagonalPorcentaje(1.5))),

                                      TextSpan(text: '\n'),

                                      TextSpan(
                                          text:
                                              'PhD. Vladimir Espartaco Robles Bykbaev',
                                          style: TextStyle(
                                              fontSize: responsive
                                                  .diagonalPorcentaje(1.5),
                                              color: Colors.black)),
                                      TextSpan(text: '\n'),
                                      TextSpan(text: '\n'),
                                      TextSpan(
                                          text: ('DISEÑADOR Y PROGRAMADOR: '),
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  19, 70, 123, 1),
                                              fontFamily: 'sans',
                                              fontSize: responsive
                                                  .diagonalPorcentaje(1.5))),
                                      TextSpan(text: '\n'),
                                      TextSpan(
                                          text:
                                              'Est. David Fernando Egas Feijoó',
                                          style: TextStyle(
                                              fontSize: responsive
                                                  .diagonalPorcentaje(1.5),
                                              color: Colors.black)),
                                      TextSpan(text: '\n'),
                                      TextSpan(text: '\n'),
                                      TextSpan(
                                          text:
                                              'Copyright ©2021, UNIVERSIDAD POLITÉCNICA SALESIANA.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 12.0,
                                              color: Colors.black))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )),
                      /*  Container(
                        padding:
                            EdgeInsets.all(responsive.diagonalPorcentaje(2)),
                        color: Colors.transparent,
                        child: RichText(
                          text: TextSpan(
                            text: utf8.decode(
                                latin1.encode(noticias.tituloNoticia + "\n"),
                                allowMalformed: true),
                            style: TextStyle(
                                fontSize: responsive.diagonalPorcentaje(3),
                                color: Color.fromRGBO(19, 70, 123, 1),
                                fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                              TextSpan(text: " " + "\n"),
                              TextSpan(
                                  text: utf8.decode(
                                      latin1.encode(noticias.contenidoNoticia),
                                      allowMalformed: true),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'sans',
                                      fontSize:
                                          responsive.diagonalPorcentaje(1.8))),
                            ],
                          ),
                        ),
                      ),*/
                      SizedBox(
                        height: responsive.diagonalPorcentaje(1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  String fecha(NoticiaM noticia) {
    String fecha = noticia.fechaNoticia.toString();
    String enviar = fecha.substring(0, 10);
    return enviar;
  }
}

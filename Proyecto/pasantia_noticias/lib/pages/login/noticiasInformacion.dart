import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pasantia_noticias/model/NoticiaM.dart';
import 'package:pasantia_noticias/pages/login/MenuLateral.dart';
import 'package:pasantia_noticias/pages/login/widgets/PrincipalGenerales.dart';
import 'package:pasantia_noticias/services/Preferencias.dart';
import 'package:pasantia_noticias/services/ServicioListarNoticias.dart';
import 'package:pasantia_noticias/utils/responsive.dart';
import 'package:pasantia_noticias/widgets/botonRegresar.dart';
import 'package:url_launcher/url_launcher.dart';

class NoticiasInformacion extends StatefulWidget {
  final NoticiaM parametro;
  final bool estado;
  final int numeroNoticia;
  NoticiasInformacion(
      {Key key, this.parametro, this.estado, this.numeroNoticia})
      : super(key: key);

  @override
  _NoticiasInformacion2State createState() => _NoticiasInformacion2State();
}

class _NoticiasInformacion2State extends State<NoticiasInformacion> {
  NoticiaM noticias;
  List<NoticiaM> datos = [];
  String categoria;
  List categorias = [];
  bool _isLoading = false;
  bool estadoVerifiacar;
  int numNoticia;
  @override
  void initState() {
    super.initState();
    // cargarNoticias();

    noticias = (widget.parametro == null) ? null : widget.parametro;
    estadoVerifiacar = (widget.estado == null) ? null : widget.estado;
    numNoticia = (widget.numeroNoticia == null) ? null : widget.numeroNoticia;
    // quitarNotificaciones();
  }

  cargarNoticias() async {
    setState(() {
      _isLoading = true;
    });
    final _preferences = new Preferences();

    datos = await ListaNoticias.getNoticias(_preferences.categorias.toString());
    noticias = datos[0];

    setState(() {
      _isLoading = false;
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
                  child: Row(
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
                        "Noticias",
                        style: TextStyle(
                            fontSize: responsive.diagonalPorcentaje(5),
                            color: Color.fromRGBO(19, 70, 123, 1),
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(responsive.diagonalPorcentaje(1)),
                  alignment: Alignment.centerRight,
                  child: RichText(
                      text: TextSpan(
                          text: "Fecha: ",
                          style: TextStyle(
                              color: Color.fromRGBO(19, 70, 123, 1),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'raleway',
                              fontSize: responsive.diagonalPorcentaje(1.5)),
                          children: <TextSpan>[
                        TextSpan(
                          text: fecha(noticias),
                          style: TextStyle(
                              color: Color.fromRGBO(19, 70, 123, 1),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'raleway',
                              fontSize: responsive.diagonalPorcentaje(1.5)),
                        )
                      ])),
                ),
                Container(
                  padding: EdgeInsets.all(responsive.diagonalPorcentaje(0)),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          image: DecorationImage(
                            image: NetworkImage(noticias.imagen),
                            fit: BoxFit.cover,
                            //  colorFilter: new ColorFilter.mode(
                            //    Colors.black.withOpacity(1), BlendMode.dstATop),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width - 5,
                        height: MediaQuery.of(context).size.height * 0.6,
                      ),
                      SizedBox(
                        height: responsive.diagonalPorcentaje(2),
                      ),
                      Container(
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
                      ),
                      SizedBox(
                        height: responsive.diagonalPorcentaje(1),
                      ),
                      Container(
                        width: 500,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Enlace Adjunto:",
                              style: TextStyle(
                                fontSize: responsive.diagonalPorcentaje(3),
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(19, 70, 123, 1),
                              ),
                            ),
                            Center(
                              child: Container(
                                alignment: Alignment.topCenter,
                                padding: EdgeInsets.only(
                                    left: responsive.diagonalPorcentaje(2)),
                                height: responsive.diagonalPorcentaje(12),
                                child: SingleChildScrollView(
                                  child: InkWell(
                                      child: Text(Url(),
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              fontSize: responsive
                                                  .diagonalPorcentaje(2.2),
                                              color: Colors.blue)),
                                      onTap: () => launch('${Url()}')),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: responsive.diagonalPorcentaje(1),
                            ),
                          ],
                        ),
                      )
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

  String Url() {
    if (noticias.enlaces != null) {
      return "${noticias.enlaces}";
    } else {
      return "No tiene enlace";
    }
  }
}

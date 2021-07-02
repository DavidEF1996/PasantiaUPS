import 'package:flutter/material.dart';
import 'package:pasantia_noticias/model/NoticiaM.dart';
import 'package:pasantia_noticias/pages/login/widgets/PrincipalGenerales.dart';
import 'package:pasantia_noticias/services/Preferencias.dart';
import 'package:pasantia_noticias/services/ServicioListarNoticias.dart';
import 'package:pasantia_noticias/utils/cabecera.dart';
import 'package:pasantia_noticias/utils/responsive.dart';
import 'package:pasantia_noticias/widgets/botonRegresar.dart';
import 'package:url_launcher/url_launcher.dart';

class NoticiasInformacion2 extends StatefulWidget {
  final NoticiaM parametro;
  NoticiasInformacion2({Key key, this.parametro}) : super(key: key);

  @override
  _NoticiasInformacion2State createState() => _NoticiasInformacion2State();
}

class _NoticiasInformacion2State extends State<NoticiasInformacion2> {
  NoticiaM noticias;
  List<NoticiaM> datos = [];
  String categoria;
  List categorias = [];
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    cargarNoticias();
    print("llego");
    noticias = (widget.parametro == null) ? null : widget.parametro;
  }

  cargarNoticias() async {
    setState(() {
      _isLoading = true;
    });
    final _preferences = new Preferences();

    print(_preferences.categorias);
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
          automaticallyImplyLeading: false,
          title: Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Cabecera(),
                Text(" "),
                //usuariologueado.botonSalir(context),
              ],
            ),
          ),
        ),
        body:
            //Container()
            Builder(builder: (_) {
          if (_isLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return SingleChildScrollView(
              child:
                  //  Container(child: ,)
                  Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment(
                        0.7, 0), // 10% of the width, so there are ten blinds.
                    colors: [
                      const Color.fromRGBO(28, 26, 24, 1),
                      const Color.fromRGBO(28, 26, 24, 1),
                    ], // red to yellow
                    tileMode: TileMode
                        .repeated, // repeats the gradient over the canvas
                  ),
                ),
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
                                color: Color.fromRGBO(255, 226, 199, 1),
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.all(responsive.diagonalPorcentaje(1.5)),
                      alignment: Alignment.centerRight,
                      child: RichText(
                          text: TextSpan(
                              text: "Fecha: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: responsive.diagonalPorcentaje(2.5)),
                              children: <TextSpan>[
                            TextSpan(
                                text: fecha(noticias),
                                style: TextStyle(
                                    fontSize:
                                        responsive.diagonalPorcentaje(2.2)))
                          ])),
                    ),
                    Container(
                      padding:
                          EdgeInsets.all(responsive.diagonalPorcentaje(2.5)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        //color: Colors.transparent,
                        gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          end: Alignment(1,
                              1), // 10% of the width, so there are ten blinds.
                          colors: [
                            const Color.fromRGBO(101, 91, 80, 1),
                            const Color.fromRGBO(28, 26, 24, 1),
                          ], // red to yellow
                          tileMode: TileMode
                              .repeated, // repeats the gradient over the canvas
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(noticias.imagen),
                                fit: BoxFit.cover,
                                colorFilter: new ColorFilter.mode(
                                    Colors.black.withOpacity(1),
                                    BlendMode.dstATop),
                              ),
                            ),
                            width: MediaQuery.of(context).size.height * 0.5,
                            height: MediaQuery.of(context).size.height * 0.35,
                          ),
                          SizedBox(
                            height: responsive.diagonalPorcentaje(2),
                          ),
                          Container(
                            color: Colors.transparent,
                            child: RichText(
                              text: TextSpan(
                                text: noticias.tituloNoticia + "\n",
                                style: TextStyle(
                                    fontSize: responsive.diagonalPorcentaje(3),
                                    color: Color.fromRGBO(255, 226, 199, 1),
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: " " + "\n",
                                  ),
                                  TextSpan(
                                      text: noticias.contenidoNoticia,
                                      style: TextStyle(
                                          fontSize: responsive
                                              .diagonalPorcentaje(2.2))),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: responsive.diagonalPorcentaje(2),
                          ),
                          SingleChildScrollView(
                            child: InkWell(
                                child: Text(Url()),
                                onTap: () => launch('${Url()}')),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        }));
  }

  String fecha(NoticiaM noticia) {
    String fecha = noticia.fechaNoticia.toString();
    String enviar = fecha.substring(0, 10);
    return enviar;
  }

  String Url() {
    print(noticias.enlaces);
    if (noticias.enlaces != "") {
      return "${noticias.enlaces}";
    } else {
      return "No tiene enlace";
    }
  }
}

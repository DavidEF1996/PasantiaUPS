import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pasantia_noticias/model/NoticiaM.dart';
import 'package:pasantia_noticias/model/auxiliarNotificaciones.dart';
import 'package:pasantia_noticias/pages/login/noticiasInformacion.dart';
import 'package:pasantia_noticias/pages/login/widgets/listaAuxiliar.dart';
import 'package:pasantia_noticias/services/Preferencias.dart';
import 'package:pasantia_noticias/utils/responsive.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DataPagerWithListView extends StatefulWidget {
  final List<NoticiaM> noticias;
  final String categoriaNombre;
  const DataPagerWithListView({Key key, this.noticias, this.categoriaNombre})
      : super(key: key);

  @override
  _DataPagerWithListView createState() => _DataPagerWithListView();
}

List<NoticiaM> _paginatedProductData = [];
List<NoticiaM> datos = [];
List<DatosNoticia> datosNoticia = [];
List<NoticiaM> _products = [];
int rowsPerPage = 3;
int contador = 0;

class _DataPagerWithListView extends State<DataPagerWithListView> {
  static int indicePaginasAux = 0;
  static const double dataPagerHeight = 60; //altura

  String nombre = "";
  bool showLoadingIndicator = false;
  double pageCount = 0;
  @override
  void initState() {
    super.initState();
    final _preferences = new Preferences();
    Auxiliar.datosNoticia = [];
    _products = (widget.noticias == null) ? null : widget.noticias;
    datos = (widget.noticias == null) ? null : widget.noticias;
    nombre = (widget.categoriaNombre == "") ? "" : widget.categoriaNombre;

    pageCount =
        (datos.length / rowsPerPage).ceilToDouble(); //cantidad de paginas

    print(datos.length);
  }

  void rebuildList() {
    setState(() {});
  }

  String getNombre(String categoria) {
    if (categoria == "noticias") {
      return "Noticia: ";
    } else if (categoria == "emergencias") {
      return "Urgente: ";
    } else if (categoria == "ofertasLaborales") {
      return "Oferta Laboral: ";
    } else if (categoria == "ofertasCursos") {
      return "Oferta Curso: ";
    } else if (categoria == "") {
      return "";
    }
  }

  Widget loadListView(BoxConstraints constraints) {
    List<Widget> _getChildren() {
      final List<Widget> stackChildren = [];

      if (_products.isNotEmpty) {
        print("Esteeee es el indeeex " + indexBuilder.toString());
        stackChildren.add(ListView.custom(
            childrenDelegate: CustomSliverChildBuilderDelegate(indexBuilder)));
      }

      if (showLoadingIndicator) {
        stackChildren.add(Container(
          //contenedor para guardar las

          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              strokeWidth: 4,
            ),
          ),
        ));
      }
      return stackChildren;
    }

    return Stack(
      children: _getChildren(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: LayoutBuilder(builder: (context, constraint) {
      return Column(
        children: [
          Container(
            height: constraint.maxHeight - dataPagerHeight,
            child: loadListView(constraint),
          ),
          Container(
            height: dataPagerHeight,
            child: SfDataPagerTheme(
                data: SfDataPagerThemeData(
                  selectedItemTextStyle: TextStyle(color: Colors.black),
                  // itemTextStyle: TextStyle(color: Colors.black),
                  selectedItemColor: Color.fromRGBO(252, 216, 127, 1),
                  itemBorderRadius: BorderRadius.circular(10),
                  //radio cirular del indicador de paginas
                ),
                child: SfDataPager(
                    pageCount: pageCount,
                    onPageNavigationStart: (pageIndex) {
                      setState(() {
                        showLoadingIndicator = true;
                      });
                    },
                    onPageNavigationEnd: (pageIndex) {
                      setState(() {
                        indicePaginasAux = pageIndex;
                        showLoadingIndicator = false;
                      });
                    },
                    delegate: CustomSliverChildBuilderDelegate(indexBuilder)
                      ..addListener(rebuildList))),
          )
        ],
      );
    }));
  }

  Widget indexBuilder(BuildContext context, int index) {
    final Responsive responsive = Responsive.of(context);
    final NoticiaM data = _paginatedProductData[index];
    //final NoticiaM data = datos[index];
    return Container(
        child: ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: LayoutBuilder(
        builder: (context, constraint) {
          return Container(
              width: constraint.maxWidth,
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      width: constraint.maxWidth,
                      margin: EdgeInsets.zero,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          image: DecorationImage(
                            image: NetworkImage(data.imagen),
                            fit: BoxFit.cover,
                          )),
                      height: responsive.diagonalPorcentaje(20),
                      child: InkWell(
                        onTap: () {
                          // if (Auxiliar.datosNoticia[index].indice ==
                          //   index) {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (context) => new NoticiasInformacion(
                                parametro: data,
                                numeroNoticia: index,
                                // estado: Auxiliar
                                //   .datosNoticia[index].estado),
                              ),
                            ),
                          );
                          // }
                        },
                        child: Container(
                            color: Colors.transparent, child: Container()),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      width: constraint.maxWidth,
                      margin: EdgeInsets.only(bottom: 10.0),
                      //  color: Color.fromRGBO(255, 226, 199, 1),
                      height: responsive.diagonalPorcentaje(5.5),
                      child: InkWell(
                        onTap: () {
                          // if (Auxiliar.datosNoticia[index].indice ==
                          //   index) {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (context) => new NoticiasInformacion(
                                parametro: data,
                                numeroNoticia: index,
                                // estado: Auxiliar
                                //   .datosNoticia[index].estado),
                              ),
                            ),
                          );
                          // }
                        },
                        child: SingleChildScrollView(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(18, 69, 122, 1),
                              border: Border(
                                bottom:
                                    BorderSide(width: 1, color: Colors.black),
                                left: BorderSide(width: 1, color: Colors.black),
                                right:
                                    BorderSide(width: 1, color: Colors.black),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.8),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            //height: constraint.minHeight,
                            padding: EdgeInsets.all(
                                responsive.diagonalPorcentaje(1)),

                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  RichText(
                                    text: TextSpan(
                                      text: getNombre(nombre),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: responsive
                                              .diagonalPorcentaje(1.8)),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: utf8.decode(
                                                latin1
                                                    .encode(data.tituloNoticia),
                                                allowMalformed: true),
                                            style: TextStyle(
                                                fontSize: responsive
                                                    .diagonalPorcentaje(1.7))),
                                      ],
                                    ),
                                  ),
                                  // Row(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  // children: [
                                  //padding(Icon(Icons.check)),
                                  //padding(Text(noticias.name, style: TextStyle(fontSize: 10))),

                                  //  ],
                                  // )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ));
        },
      ),
    ));
  }

  /* String textoNuevaNotificacion(int index) {
    print("Se llamo de nuevo");

    print("UNOOOO" + Auxiliar.datosNoticia.toString());
    print("DOOOSS" + index.toString());
    DatosNoticia datos = new DatosNoticia();
    int contador;
    int valorInicial;
    final _preferences = new Preferences();
    //_preferences.numeroNoticia = 0;
    valorInicial = _preferences.numeroNoticia;

    if (index < valorInicial && indicePaginasAux == 0) {
      datos.indice = index;
      datos.estado = true;

      if (Auxiliar.datosNoticia.length <= 2) {
        Auxiliar.datosNoticia.add(datos);
      }

      return "Nueva Noticia";
    } else {
      datos.indice = index;
      datos.estado = false;
      if (Auxiliar.datosNoticia.length <= 2) {
        Auxiliar.datosNoticia.add(datos);
      }

      return "";
    }
  }*/

  /* String textoNuevaNotificacion(int index) {
    print("Dato = " + Auxiliar.datosNoticia[0].estado.toString());
    final _preferences = new Preferences();
    int valorInicial = _preferences.numeroNoticia;
    if (index < valorInicial) {
      return "Nueva Noticia";
    } else {
      return "";
    }
  }*/
}

Widget padding(Widget widget) {
  return Padding(
    padding: EdgeInsets.all(7.0),
    child: widget,
  );
}

class CustomSliverChildBuilderDelegate extends SliverChildBuilderDelegate
    with DataPagerDelegate, ChangeNotifier {
  CustomSliverChildBuilderDelegate(builder) : super(builder);

  @override
  int get childCount => _paginatedProductData.length;

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    int startRowIndex = newPageIndex * rowsPerPage;
    int endRowIndex = startRowIndex + rowsPerPage;

    if (endRowIndex > _products.length) {
      endRowIndex = _products.length;
    }

    await Future.delayed(Duration(milliseconds: 2000));
    _paginatedProductData =
        _products.getRange(startRowIndex, endRowIndex).toList(growable: false);

    notifyListeners();
    return true;
  }

  @override
  bool shouldRebuild(covariant CustomSliverChildBuilderDelegate oldDelegate) {
    return true;
  }
}

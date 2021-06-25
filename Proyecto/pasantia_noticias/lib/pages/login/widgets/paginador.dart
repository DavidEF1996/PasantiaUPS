import 'package:flutter/material.dart';
import 'package:pasantia_noticias/model/NoticiaM.dart';
import 'package:pasantia_noticias/pages/login/noticiasInformacion.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DataPagerWithListView extends StatefulWidget {
  final List<NoticiaM> noticias;
  const DataPagerWithListView({Key key, this.noticias}) : super(key: key);

  @override
  _DataPagerWithListView createState() => _DataPagerWithListView();
}

List<NoticiaM> _paginatedProductData = [];
List<NoticiaM> datos = [];

List<NoticiaM> _products = [];
int rowsPerPage = 3;

class _DataPagerWithListView extends State<DataPagerWithListView> {
  static const double dataPagerHeight = 60; //altura

  bool showLoadingIndicator = false;
  double pageCount = 0;
  @override
  void initState() {
    super.initState();
    _products = (widget.noticias == null) ? null : widget.noticias;
    datos = (widget.noticias == null) ? null : widget.noticias;
    pageCount =
        (datos.length / rowsPerPage).ceilToDouble(); //cantidad de paginas

    print(datos.length);
  }

  void rebuildList() {
    setState(() {});
  }

  Widget loadListView(BoxConstraints constraints) {
    List<Widget> _getChildren() {
      final List<Widget> stackChildren = [];

      if (_products.isNotEmpty) {
        stackChildren.add(ListView.custom(
            childrenDelegate: CustomSliverChildBuilderDelegate(indexBuilder)));
      }

      if (showLoadingIndicator) {
        stackChildren.add(Container(
          //contenedor para guardar las
          color: Colors.black12,
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
                  itemBorderRadius: BorderRadius.circular(
                      10), //radio cirular del indicador de paginas
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
    final NoticiaM data = _paginatedProductData[index];
    //final NoticiaM data = datos[index];
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end:
                Alignment(0.7, 0), // 10% of the width, so there are ten blinds.
            colors: [
              const Color.fromRGBO(28, 26, 24, 1),
              const Color.fromRGBO(28, 26, 24, 1),
            ], // red to yellow
            tileMode: TileMode.repeated, // repeats the gradient over the canvas
          ),
        ),
        child: ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: LayoutBuilder(
            builder: (context, constraint) {
              return Container(
                  width: constraint.maxWidth,
                  child: Row(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          width: constraint.maxWidth,
                          margin: EdgeInsets.only(bottom: 10.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              image: DecorationImage(
                                image: NetworkImage(data.imagen),
                                fit: BoxFit.cover,
                                colorFilter: new ColorFilter.mode(
                                    Colors.black.withOpacity(0.2),
                                    BlendMode.dstATop),
                              )),
                          height: 150,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                  builder: (context) =>
                                      new NoticiasInformacion(data),
                                ),
                              );
                            },
                            child: Card(
                              color: Colors.transparent,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  padding(Text(data.categoriaNoticia,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromRGBO(
                                              255, 226, 199, 1)))),
                                  // Row(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  // children: [
                                  //padding(Icon(Icons.check)),
                                  //padding(Text(noticias.name, style: TextStyle(fontSize: 10))),
                                  Column(
                                    children: [
                                      Text(
                                        data.tituloNoticia,
                                        style: TextStyle(
                                            decorationThickness: 3,
                                            height: 2,
                                            color: Color.fromRGBO(
                                                255, 226, 199, 1)),
                                        maxLines: 3,
                                      ),
                                    ],
                                  )
                                  //  ],
                                  // )
                                ],
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
      endRowIndex = _products.length - 1;
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

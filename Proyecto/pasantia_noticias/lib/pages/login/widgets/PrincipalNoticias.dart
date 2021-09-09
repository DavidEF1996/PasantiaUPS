import 'package:flutter/material.dart';
import 'package:pasantia_noticias/model/NoticiaM.dart';
import 'package:pasantia_noticias/pages/login/MenuLateral.dart';
import 'package:pasantia_noticias/pages/login/widgets/paginador.dart';
import 'package:pasantia_noticias/services/LoginService.dart';
import 'package:pasantia_noticias/services/Preferencias.dart';
import 'package:pasantia_noticias/services/ServicioListarNoticias.dart';
import 'package:pasantia_noticias/utils/responsive.dart';

class PrincipalNoticias extends StatefulWidget {
  final String categoriaEnviar;

  const PrincipalNoticias({Key key, this.categoriaEnviar = ""})
      : super(key: key);
  @override
  _PrincipalNoticiasState createState() => _PrincipalNoticiasState();
}

class _PrincipalNoticiasState extends State<PrincipalNoticias> {
  bool _isLoading = false;
  List<NoticiaM> datos = [];
  String categoria;

  @override
  initState() {
    categoria =
        (widget.categoriaEnviar == "") ? "noticias" : widget.categoriaEnviar;

    cargarNoticias();
    super.initState();

    if (categoria == "emergencias") {
      final _preferences = new Preferences();
      _preferences.noticia1 = 0;
    } else if (categoria == "noticias") {
      final _preferences = new Preferences();
      _preferences.noticia2 = 0;
    } else if (categoria == "ofertasLaborales") {
      final _preferences = new Preferences();
      _preferences.noticia3 = 0;
    } else if (categoria == "ofertasCursos") {
      final _preferences = new Preferences();
      _preferences.noticia4 = 0;
    }
  }

  cargarNoticias() async {
    setState(() {
      _isLoading = true;
    });
    datos = await ListaNoticias.getNoticias(categoria);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return SafeArea(
      child: Scaffold(
          appBar: new AppBar(
            title: Container(
              alignment: Alignment.bottomLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Cabecera(),

                  //usuariologueado.botonSalir(context),
                ],
              ),
            ),
          ),
          drawer: MenuLateral(),
          body: Builder(builder: (_) {
            if (_isLoading) {
              return Center(child: CircularProgressIndicator());
            } else {
              return comprobar();
            }
          })),
    );
  }

  Container comprobar() {
    if (datos.length > 0) {
      return Container(
          color: Color.fromRGBO(250, 250, 250, 1),
          child: DataPagerWithListView(
            noticias: datos,
            categoriaNombre: categoria,
          ));
    } else {
      return Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                "No se han cargado noticias",
                style: TextStyle(color: Colors.black, fontSize: 40),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Navegue a otra ventana del menu lateral o espere a que un administrador ingrese nuevas noticias.",
              style: TextStyle(
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }
  }
}

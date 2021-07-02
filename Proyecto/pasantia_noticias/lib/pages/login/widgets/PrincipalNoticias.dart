import 'package:flutter/material.dart';
import 'package:pasantia_noticias/model/NoticiaM.dart';
import 'package:pasantia_noticias/pages/login/MenuLateral.dart';
import 'package:pasantia_noticias/pages/login/noticiasInformacion.dart';
import 'package:pasantia_noticias/pages/login/widgets/ListNotices.dart';
import 'package:pasantia_noticias/pages/login/widgets/notices.dart';
import 'package:pasantia_noticias/pages/login/widgets/paginador.dart';
import 'package:pasantia_noticias/services/LoginService.dart';
import 'package:pasantia_noticias/services/Preferencias.dart';
import 'package:pasantia_noticias/services/ServicioListarNoticias.dart';
import 'package:pasantia_noticias/utils/responsive.dart';
import 'package:pasantia_noticias/widgets/cabecera.dart';

class PrincipalNoticias extends StatefulWidget {
  final String categoriaEnviar;

  const PrincipalNoticias({Key key, this.categoriaEnviar = ""})
      : super(key: key);
  @override
  _PrincipalNoticiasState createState() => _PrincipalNoticiasState();
}

class _PrincipalNoticiasState extends State<PrincipalNoticias> {
  bool _isLoading = false;
  List<Noticias> noticias = Noticias.noticias_album();
  List<NoticiaM> datos = [];
  String categoria;

  @override
  initState() {
    categoria =
        (widget.categoriaEnviar == "") ? "noticias" : widget.categoriaEnviar;

    cargarNoticias();
    super.initState();
    print("EEEEEEEEEEEEEEEEE0 " + categoria);

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
    print(UserService.usuariologueado);
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
      print(datos.length);
      return Container(
          color: Colors.white,
          child: DataPagerWithListView(
            noticias: datos,
            categoriaNombre: categoria,
          ));
    } else {
      return Container(
        child: Text("Aún no se ha cargado ninguna noticia"),
      );
    }
  }
}

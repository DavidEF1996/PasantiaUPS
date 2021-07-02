import 'package:flutter/material.dart';
import 'package:pasantia_noticias/model/NoticiaM.dart';
import 'package:pasantia_noticias/pages/login/MenuLateral.dart';
import 'package:pasantia_noticias/pages/login/widgets/notices.dart';
import 'package:pasantia_noticias/pages/login/widgets/paginador.dart';
import 'package:pasantia_noticias/services/LoginService.dart';
import 'package:pasantia_noticias/services/Preferencias.dart';
import 'package:pasantia_noticias/services/ServicioListarNoticias.dart';
import 'package:pasantia_noticias/utils/responsive.dart';
import 'package:pasantia_noticias/widgets/cabecera.dart';

class PrincipalNo extends StatefulWidget {
  PrincipalNo({Key key}) : super(key: key);

  @override
  _PrincipalNoState createState() => _PrincipalNoState();
}

class _PrincipalNoState extends State<PrincipalNo> {
  bool _isLoading = false;
  List<Noticias> noticias = Noticias.noticias_album();
  List<NoticiaM> datos = [];

  @override
  initState() {
    cargarNoticias();
    super.initState();
    final _preferences = new Preferences();
    _preferences.numeroNoticia = 0;
  }

  cargarNoticias() async {
    setState(() {
      _isLoading = true;
    });
    datos = await ListaNoticias.getNoticiasGenerales();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(UserService.usuariologueado);
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
        body: Builder(builder: (_) {
          if (_isLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return comprobar();
          }
        }));
  }

  Container comprobar() {
    if (datos.length > 0) {
      /*  NoticiaM n = new NoticiaM();
      n.tituloNoticia="Sin datos";
      n.imagen=null;
      n.fechaNoticia=DateTime.now();
      n.enlaces="Sin datos";
      n.*/
      print("este es: " + datos.length.toString());
      return Container(
          color: Colors.white,
          child: DataPagerWithListView(
            noticias: datos,
          ));
    } else {
      return Container(
        child: Text("Aún no se ha cargado ninguna noticia"),
      );
    }
  }
}

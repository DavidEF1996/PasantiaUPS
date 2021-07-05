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
      print(datos.length);
      return Container(
          color: Color.fromRGBO(250, 250, 250, 1),
          child: DataPagerWithListView(
            noticias: datos,
            categoriaNombre: 'Todo',
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

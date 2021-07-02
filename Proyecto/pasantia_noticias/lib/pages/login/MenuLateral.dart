import 'package:flutter/material.dart';
import 'package:pasantia_noticias/pages/login/Administracion.dart';
import 'package:pasantia_noticias/pages/login/loginPage.dart';
import 'package:pasantia_noticias/pages/login/widgets/PrincipalGenerales.dart';
import 'package:pasantia_noticias/pages/login/widgets/PrincipalNoticias.dart';
import 'package:pasantia_noticias/services/LoginService.dart';
import 'package:pasantia_noticias/services/Preferencias.dart';
import 'package:pasantia_noticias/utils/responsive.dart';
import 'package:pasantia_noticias/widgets/cabecera.dart';

class MenuLateral extends StatefulWidget {
  MenuLateral({Key key}) : super(key: key);

  @override
  _MenuLateralState createState() => _MenuLateralState();
}

class _MenuLateralState extends State<MenuLateral> {
  String rol = "";
  int contadorEmeregencias;
  int contadorNoticias;
  int contadorTodo;
  int contadorOfertasLaborales;
  int contadorOfertasCursos;
  @override
  void initState() {
    super.initState();
    final _preferences = new Preferences();
    print(_preferences.nombres);
    print(_preferences.roles);
    rol = _preferences.roles.toString();
    contadorEmeregencias = _preferences.noticia1;
    contadorNoticias = _preferences.noticia2;
    contadorTodo = _preferences.numeroNoticia;
    contadorOfertasLaborales = _preferences.noticia3;
    contadorOfertasCursos = _preferences.noticia4;
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return SafeArea(
      child: Container(
        child: new Drawer(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: ListView(
              children: [
                new UserAccountsDrawerHeader(
                    accountName: Container(
                      alignment: Alignment.bottomCenter,
                      //child: Cabecera(),
                    ),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(101, 91, 80, 0.80),
                        image: DecorationImage(
                          image: AssetImage('assets/giata.png'),
                          fit: BoxFit.fill,

                          //  colorFilter: new ColorFilter.mode(
                          //    Colors.black.withOpacity(0.5), BlendMode.dstATop),
                        ))),
                Container(
                  height: responsive.diagonalPorcentaje(7.5),
                  child: Cabecera(),
                ),
                Container(
                  color: Colors.red,
                  child: Ink(
                    color: Colors.blue,
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Emergencias'),
                          contadores(contadorEmeregencias)
                        ],
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                            builder: (context) => new PrincipalNoticias(
                              categoriaEnviar: "emergencias",
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  color: Color.fromRGBO(255, 186, 0, 0.5),
                  child: Column(
                    children: [
                      Ink(
                        color: Colors.blue,
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text('Todo'), contadores(contadorTodo)],
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              new MaterialPageRoute(
                                builder: (context) => new PrincipalNo(),
                              ),
                            );
                          },
                        ),
                      ),
                      Ink(
                        color: Colors.blue,
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Noticias'),
                              contadores(contadorNoticias)
                            ],
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              new MaterialPageRoute(
                                builder: (context) => new PrincipalNoticias(
                                  categoriaEnviar: "noticias",
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Ink(
                        color: Colors.blue,
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Ofertas de Cursos'),
                              contadores(contadorOfertasCursos)
                            ],
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              new MaterialPageRoute(
                                builder: (context) => new PrincipalNoticias(
                                  categoriaEnviar: "ofertasCursos",
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Ink(
                        color: Colors.blue,
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Ofertas Laborales'),
                              contadores(contadorOfertasLaborales)
                            ],
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              new MaterialPageRoute(
                                builder: (context) => new PrincipalNoticias(
                                  categoriaEnviar: "ofertasLaborales",
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: responsive.diagonalPorcentaje(12),
                  alignment: Alignment.bottomCenter,
                  child: (Text(
                    "Cuenta: ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: responsive.diagonalPorcentaje(2)),
                  )),
                ),
                container()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text contadores(int contador) {
    if (contador == 0) {
      return Text("");
    } else {
      return Text(contador.toString());
    }
  }

  Container container() {
    print(rol);
    if (rol == 'usuarios') {
      return Container(
        color: Color.fromRGBO(101, 91, 80, 0.7),
        child: Ink(
          color: Colors.blue,
          child: ListTile(
            title: Text("Salir"),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (BuildContext context) {
                return new LoginPage();
              }), (Route<dynamic> route) => false);
            },
          ),
        ),
      );
    } else if (rol == 'administrador') {
      return Container(
        color: Color.fromRGBO(101, 91, 80, 0.7),
        child: Column(
          children: [
            Ink(
              color: Colors.blue,
              child: ListTile(
                title: Text("Administracion"),
                onTap: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => new Administracion(),
                    ),
                  );
                },
              ),
            ),
            Ink(
              color: Colors.blue,
              child: ListTile(
                title: Text("Salir"),
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (BuildContext context) {
                    return new LoginPage();
                  }), (Route<dynamic> route) => false);
                },
              ),
            ),
          ],
        ),
      );
    }
  }
}

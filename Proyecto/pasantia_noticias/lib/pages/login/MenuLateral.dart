import 'package:flutter/material.dart';
import 'package:pasantia_noticias/pages/AcercaNosotros.dart';
import 'package:pasantia_noticias/pages/login/Administracion.dart';
import 'package:pasantia_noticias/pages/login/loginPage.dart';
import 'package:pasantia_noticias/pages/login/widgets/PrincipalGenerales.dart';
import 'package:pasantia_noticias/pages/login/widgets/PrincipalNoticias.dart';
import 'package:pasantia_noticias/services/Preferencias.dart';
import 'package:pasantia_noticias/utils/responsive.dart';
import 'package:pasantia_noticias/utils/variablesGlobales.dart';
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
  int numeroMenu = 1;
  @override
  void initState() {
    super.initState();
    final _preferences = new Preferences();

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
                Container(
                  height: responsive.diagonalPorcentaje(32.5),
                  child: new UserAccountsDrawerHeader(
                      accountName: Container(
                        alignment: Alignment.bottomCenter,
                        //child: Cabecera(),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          image: DecorationImage(
                            image: AssetImage('assets/logoUps2.jpg'),
                            fit: BoxFit.fill,

                            //  colorFilter: new ColorFilter.mode(
                            //    Colors.black.withOpacity(0.5), BlendMode.dstATop),
                          ))),
                ),
                Container(
                  height: responsive.diagonalPorcentaje(7.5),
                  child: Cabecera(),
                ),
                Container(
                  //   color: Color.fromRGBO(255, 186, 0, 0.5),

                  child: Ink(
                    child: ListTile(
                      leading: Container(
                        width: responsive.diagonalPorcentaje(3),
                        height: responsive.diagonalPorcentaje(3),
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage(rutaImagenIcono(numeroMenu = 1)),
                          backgroundColor: Colors.white,
                        ),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Urgentes',
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: responsive.diagonalPorcentaje(1.7)),
                          ),
                          contadores(contadorEmeregencias)
                        ],
                      ),
                      onTap: () {
                        VariablesGlobales.numeroMenuLateral = 1;
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
                SizedBox(
                  height: 1,
                ),
                Container(
                  //color: Color.fromRGBO(255, 186, 0, 0.5),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Container(
                          width: responsive.diagonalPorcentaje(3),
                          height: responsive.diagonalPorcentaje(3),
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage(rutaImagenIcono(numeroMenu = 2)),
                            backgroundColor: Colors.white,
                          ),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Todo',
                              style: TextStyle(
                                  fontSize: responsive.diagonalPorcentaje(1.7),
                                  fontWeight: FontWeight.bold),
                            ),
                            contadores(contadorTodo)
                          ],
                        ),
                        // ignore: sdk_version_set_literal
                        onTap: () => {
                          VariablesGlobales.numeroMenuLateral = 2,
                          Navigator.of(context).pop(),
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (context) => new PrincipalNo(),
                            ),
                          )
                        },
                      ),
                      ListTile(
                        leading: Container(
                          width: responsive.diagonalPorcentaje(3),
                          height: responsive.diagonalPorcentaje(3),
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage(rutaImagenIcono(numeroMenu = 3)),
                            backgroundColor: Colors.white,
                          ),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Noticias',
                              style: TextStyle(
                                  fontSize: responsive.diagonalPorcentaje(1.7),
                                  fontWeight: FontWeight.bold),
                            ),
                            contadores(contadorNoticias)
                          ],
                        ),
                        // ignore: sdk_version_set_literal
                        onTap: () => {
                          VariablesGlobales.numeroMenuLateral = 3,
                          Navigator.of(context).pop(),
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (context) => new PrincipalNoticias(
                                categoriaEnviar: "noticias",
                              ),
                            ),
                          )
                        },
                      ),
                      ListTile(
                        leading: Container(
                          width: responsive.diagonalPorcentaje(3),
                          height: responsive.diagonalPorcentaje(3),
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage(rutaImagenIcono(numeroMenu = 4)),
                            backgroundColor: Colors.white,
                          ),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Ofertas de Cursos',
                              style: TextStyle(
                                  fontSize: responsive.diagonalPorcentaje(1.7),
                                  fontWeight: FontWeight.bold),
                            ),
                            contadores(contadorOfertasCursos)
                          ],
                        ),
                        // ignore: sdk_version_set_literal
                        onTap: () => {
                          VariablesGlobales.numeroMenuLateral = 4,
                          Navigator.of(context).pop(),
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (context) => new PrincipalNoticias(
                                categoriaEnviar: "ofertasCursos",
                              ),
                            ),
                          )
                        },
                      ),

                      ListTile(
                        leading: Container(
                          width: responsive.diagonalPorcentaje(3),
                          height: responsive.diagonalPorcentaje(3),
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage(rutaImagenIcono(numeroMenu = 5)),
                            backgroundColor: Colors.white,
                          ),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Ofertas Laborales',
                              style: TextStyle(
                                  fontSize: responsive.diagonalPorcentaje(1.7),
                                  fontWeight: FontWeight.bold),
                            ),
                            contadores(contadorOfertasLaborales)
                          ],
                        ),
                        // ignore: sdk_version_set_literal
                        onTap: () => {
                          VariablesGlobales.numeroMenuLateral = 5,
                          Navigator.of(context).pop(),
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (context) => new PrincipalNoticias(
                                categoriaEnviar: "ofertasLaborales",
                              ),
                            ),
                          )
                        },
                      ),

                      //-----
                      /*Ink(
                        color: Colors.blue,
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Todo',
                                style: TextStyle(
                                    fontSize:
                                        responsive.diagonalPorcentaje(1.7),
                                    fontWeight: FontWeight.bold),
                              ),
                              contadores(contadorTodo)
                            ],
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
                      Container(
                        height: 1,
                        color: Colors.white,
                      ),
                      Ink(
                        color: Colors.blue,
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Noticias',
                                style: TextStyle(
                                    fontSize:
                                        responsive.diagonalPorcentaje(1.7),
                                    fontWeight: FontWeight.bold),
                              ),
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
                      Container(
                        height: 1,
                        color: Colors.white,
                      ),
                      Ink(
                        color: Colors.blue,
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Ofertas de Cursos',
                                style: TextStyle(
                                    fontSize:
                                        responsive.diagonalPorcentaje(1.7),
                                    fontWeight: FontWeight.bold),
                              ),
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
                      Container(
                        height: 1,
                        color: Colors.white,
                      ),
                      Ink(
                        color: Colors.blue,
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Ofertas Laborales',
                                style: TextStyle(
                                    fontSize:
                                        responsive.diagonalPorcentaje(1.7),
                                    fontWeight: FontWeight.bold),
                              ),
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
                      ),*/
                    ],
                  ),
                ),
                SizedBox(height: responsive.diagonalPorcentaje(1.5)),
                Container(
                  height: responsive.diagonalPorcentaje(4),
                  alignment: Alignment.bottomCenter,
                  child: (Text(
                    "Cuenta: ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(18, 69, 122, 1),
                        fontSize: responsive.diagonalPorcentaje(2)),
                  )),
                ),
                container(responsive),
                SizedBox(height: responsive.diagonalPorcentaje(3)),
                Container(
                  height: responsive.diagonalPorcentaje(4),
                  alignment: Alignment.bottomCenter,
                  child: (Text(
                    "Más: ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(18, 69, 122, 1),
                        fontSize: responsive.diagonalPorcentaje(2)),
                  )),
                ),
                Ink(
                  color: Colors.blue,
                  child: ListTile(
                    leading: Container(
                      width: responsive.diagonalPorcentaje(3),
                      height: responsive.diagonalPorcentaje(3),
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/sobrenosotros.png'),
                        backgroundColor: Colors.white,
                      ),
                    ),
                    title: Text(
                      "Acerca de Nosotros",
                      style: TextStyle(
                          fontSize: responsive.diagonalPorcentaje(1.7),
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => new AcercaNosotros(),
                        ),
                      );
                    },
                  ),
                ),
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

  Container container(Responsive responsive) {
    if (rol == 'usuarios') {
      return Container(
        // color: Color.fromRGBO(101, 91, 80, 0.5),
        child: Ink(
          color: Colors.blue,
          child: ListTile(
            leading: Container(
              width: responsive.diagonalPorcentaje(3),
              height: responsive.diagonalPorcentaje(3),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/power-button.png'),
                backgroundColor: Colors.white,
              ),
            ),
            title: Text(
              "Salir",
              style: TextStyle(
                  fontSize: responsive.diagonalPorcentaje(1.7),
                  fontWeight: FontWeight.bold),
            ),
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
        // color: Color.fromRGBO(101, 91, 80, 0.7),
        child: Column(
          children: [
            Ink(
              color: Colors.blue,
              child: ListTile(
                leading: Container(
                  width: responsive.diagonalPorcentaje(3),
                  height: responsive.diagonalPorcentaje(3),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/user.png'),
                    backgroundColor: Colors.white,
                  ),
                ),
                title: Text(
                  "Administración",
                  style: TextStyle(
                      fontSize: responsive.diagonalPorcentaje(1.7),
                      fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  /* Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => new Administracion(),
                    ),
                  );*/

                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => new Administracion(),
                    ),
                  );
                },
              ),
            ),
            Container(
              height: 1,
              color: Colors.white,
            ),
            Ink(
              color: Colors.blue,
              child: ListTile(
                leading: Container(
                  width: responsive.diagonalPorcentaje(3),
                  height: responsive.diagonalPorcentaje(3),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/power-button.png'),
                    backgroundColor: Colors.white,
                  ),
                ),
                title: Text(
                  "Salir",
                  style: TextStyle(
                      fontSize: responsive.diagonalPorcentaje(1.7),
                      fontWeight: FontWeight.bold),
                ),
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

  String rutaImagenIcono(int numero) {
    if (VariablesGlobales.numeroMenuLateral == numero) {
      return 'assets/puntoColor.png';
    } else {
      return 'assets/puntoSinColor.png';
    }
  }
}

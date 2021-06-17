import 'package:flutter/material.dart';
import 'package:pasantia_noticias/pages/login/Administracion.dart';
import 'package:pasantia_noticias/pages/login/loginPage.dart';
import 'package:pasantia_noticias/pages/login/widgets/PrincipalGenerales.dart';
import 'package:pasantia_noticias/pages/login/widgets/PrincipalNoticias.dart';
import 'package:pasantia_noticias/services/Preferencias.dart';

class MenuLateral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Drawer(
        child: Container(
          color: Color.fromRGBO(255, 226, 199, 1),
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              new UserAccountsDrawerHeader(
                  accountName: Text("UsuarioLogueado"),
                  accountEmail: Text(""),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(101, 91, 80, 0.80),
                      image: DecorationImage(
                        image: AssetImage('assets/donBosco.png'),
                        fit: BoxFit.cover,
                        colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(0.5), BlendMode.dstATop),
                      ))),
              Ink(
                color: Colors.blue,
                child: ListTile(
                  title: Text("Todo"),
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
                  title: Text("Emergencias"),
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
              Ink(
                color: Colors.blue,
                child: ListTile(
                  title: Text("Noticias"),
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
                  title: Text("Ofertas de Cursos"),
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
                  title: Text("Ofertas Laborales"),
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
              Ink(
                color: Colors.blue,
                child: ListTile(
                  title: Text("Administracion"),
                  onTap: () {
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
              Ink(
                color: Colors.blue,
                child: ListTile(
                  title: Text("Salir"),
                  onTap: () {
                    final preferences = new Preferences();
                    preferences.id == "";

                    final route = MaterialPageRoute(builder: (context) {
                      return LoginPage();
                    });
                    Navigator.pushReplacement(context, route);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

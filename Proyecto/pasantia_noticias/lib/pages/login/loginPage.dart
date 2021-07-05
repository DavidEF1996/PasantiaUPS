import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pasantia_noticias/services/Preferencias.dart';
import 'package:pasantia_noticias/utils/responsive.dart';
import 'package:pasantia_noticias/widgets/login_form.dart';
import 'package:pasantia_noticias/widgets/welcome.dart';

class LoginPage extends StatefulWidget {
  final String usuario;
  final String contrasena;

  const LoginPage({Key key, this.usuario = "", this.contrasena = ""})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    final _preferences = new Preferences();
    _preferences.id = "";
    _preferences.nombres = "";
    _preferences.roles = "";
    _preferences.noticia1 = 0;
    _preferences.noticia2 = 0;
    _preferences.noticia3 = 0;
    _preferences.noticia4 = 0;
    _preferences.numeroNoticia = 0;
    print(widget.usuario);
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return SafeArea(
      child: Container(
        // color: Colors.white,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromRGBO(252, 216, 127, 1),
            Colors.white,
          ],
        )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: Container(
                        height: responsive.diagonalPorcentaje(30),
                        child: Welcome(),
                      ),
                    ),
                    SizedBox(
                      height: responsive.diagonalPorcentaje(0.001),
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            // color: Color.fromRGBO(18, 69, 122, 0.8),

                            gradient: LinearGradient(
                              begin: Alignment.bottomRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color.fromRGBO(18, 69, 122, 1),
                                Colors.grey,
                              ],
                            )),
                        padding: EdgeInsets.all(19),
                        child: LoginForm(
                          usuario: widget.usuario,
                          contrasena: widget.contrasena,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

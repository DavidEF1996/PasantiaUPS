import 'package:flutter/material.dart';
import 'package:pasantia_noticias/pages/login/MenuLateral.dart';
import 'package:pasantia_noticias/pages/login/noticiasInformacion.dart';
import 'package:pasantia_noticias/pages/login/widgets/ListNotices.dart';
import 'package:pasantia_noticias/pages/login/widgets/notices.dart';
import 'package:pasantia_noticias/pages/login/widgets/paginador.dart';
import 'package:pasantia_noticias/services/LoginService.dart';
import 'package:pasantia_noticias/utils/responsive.dart';
import 'package:pasantia_noticias/widgets/cabecera.dart';

class PrincipalEmergencias extends StatelessWidget {
  List<Noticias> noticias = Noticias.noticias_album();

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments ?? 'No tiene informacion';

    print(UserService.usuariologueado);
    final Responsive responsive = Responsive.of(context);
    return Scaffold(
      appBar: new AppBar(
        title: Container(
          alignment: Alignment.bottomLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Cabecera(),
              Text(" "),
              //usuariologueado.botonSalir(context),
            ],
          ),
        ),
      ),
      drawer: MenuLateral(),
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment(
                  0.7, 0), // 10% of the width, so there are ten blinds.
              colors: [
                const Color.fromRGBO(28, 26, 24, 1),
                const Color.fromRGBO(28, 26, 24, 1),
              ], // red to yellow
              tileMode:
                  TileMode.repeated, // repeats the gradient over the canvas
            ),
          ),
          child: DataPagerWithListView()),
    );
  }
}

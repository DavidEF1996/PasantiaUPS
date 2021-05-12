import 'package:flutter/material.dart';
import 'package:pasantia_noticias/pages/login/MenuLateral.dart';
import 'package:pasantia_noticias/pages/login/noticiasInformacion.dart';
import 'package:pasantia_noticias/pages/login/widgets/ListNotices.dart';
import 'package:pasantia_noticias/pages/login/widgets/notices.dart';
import 'package:pasantia_noticias/utils/responsive.dart';

class PrincipalNoticias extends StatelessWidget {
  List<Noticias> noticias = Noticias.noticias_album();

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Scaffold(
      appBar: new AppBar(
        title: Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("Usuario:")],
          ),
        ),
      ),
      drawer: MenuLateral(),
      body: Container(
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
        child: Column(
          children: [
            Container(
              child: Text(
                "Noticias",
                style: TextStyle(
                    fontSize: responsive.diagonalPorcentaje(5),
                    color: Color.fromRGBO(255, 226, 199, 1),
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListNotices(),
            )
          ],
        ),
      ),
    );
  }
}

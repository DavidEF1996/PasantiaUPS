import 'package:flutter/material.dart';
import 'package:pasantia_noticias/pages/login/widgets/notices.dart';
import 'package:pasantia_noticias/utils/responsive.dart';

class NoticiasInformacion extends StatelessWidget {
  Noticias noticias;
  NoticiasInformacion(this.noticias);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Container(child: Text(noticias.fecha)),
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(noticias.image),
                  fit: BoxFit.cover,
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.6), BlendMode.dstATop),
                ),
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
              width: MediaQuery.of(context).size.height * 0.5,
              height: MediaQuery.of(context).size.height * 0.35,
            ),
            Container(
              color: Colors.white,
              child: RichText(
                text: TextSpan(
                  text: noticias.title + "\n",
                  style: TextStyle(
                      fontSize: responsive.diagonalPorcentaje(4),
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                        text: noticias.name,
                        style: TextStyle(
                            fontSize: responsive.diagonalPorcentaje(3))),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

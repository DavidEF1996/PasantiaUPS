import 'package:flutter/material.dart';
import 'package:pasantia_noticias/pages/login/widgets/ListNotices.dart';
import 'package:pasantia_noticias/pages/login/widgets/PrincipalNoticias.dart';
import 'package:pasantia_noticias/pages/login/widgets/notices.dart';
import 'package:pasantia_noticias/utils/responsive.dart';
import 'package:pasantia_noticias/widgets/botonRegresar.dart';
import 'package:pasantia_noticias/widgets/botonReusable.dart';

class NoticiasInformacion extends StatelessWidget {
  Noticias noticias;
  NoticiasInformacion(this.noticias);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("Usuario:")],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
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
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    BotonRegresar(
                        onPressed: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (context) => new PrincipalNoticias(),
                            ),
                          );
                        },
                        label: "Regresar"),
                    SizedBox(width: responsive.diagonalPorcentaje(4.5)),
                    Text(
                      "Noticias",
                      style: TextStyle(
                          fontSize: responsive.diagonalPorcentaje(5),
                          color: Color.fromRGBO(255, 226, 199, 1),
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(responsive.diagonalPorcentaje(1.5)),
                alignment: Alignment.centerRight,
                child: RichText(
                    text: TextSpan(
                        text: "Fecha: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: responsive.diagonalPorcentaje(2.5)),
                        children: <TextSpan>[
                      TextSpan(
                          text: noticias.fecha,
                          style: TextStyle(
                              fontSize: responsive.diagonalPorcentaje(2.2)))
                    ])),
              ),
              Container(
                padding: EdgeInsets.all(responsive.diagonalPorcentaje(2.5)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  //color: Colors.transparent,
                  gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment(
                        1, 1), // 10% of the width, so there are ten blinds.
                    colors: [
                      const Color.fromRGBO(101, 91, 80, 1),
                      const Color.fromRGBO(28, 26, 24, 1),
                    ], // red to yellow
                    tileMode: TileMode
                        .repeated, // repeats the gradient over the canvas
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(noticias.image),
                          fit: BoxFit.cover,
                          colorFilter: new ColorFilter.mode(
                              Colors.black.withOpacity(1), BlendMode.dstATop),
                        ),
                      ),
                      width: MediaQuery.of(context).size.height * 0.5,
                      height: MediaQuery.of(context).size.height * 0.35,
                    ),
                    SizedBox(
                      height: responsive.diagonalPorcentaje(2),
                    ),
                    Container(
                      color: Colors.transparent,
                      child: RichText(
                        text: TextSpan(
                          text: noticias.titulo + "\n",
                          style: TextStyle(
                              fontSize: responsive.diagonalPorcentaje(3),
                              color: Color.fromRGBO(255, 226, 199, 1),
                              fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(text: " " + "\n"),
                            TextSpan(
                                text: noticias.contenido,
                                style: TextStyle(
                                    fontSize:
                                        responsive.diagonalPorcentaje(2.2))),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

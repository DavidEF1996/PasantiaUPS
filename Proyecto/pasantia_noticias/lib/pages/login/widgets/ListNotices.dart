import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pasantia_noticias/pages/login/widgets/notices.dart';
import 'package:pasantia_noticias/pages/login/widgets/notices_card.dart';
import 'package:pasantia_noticias/utils/responsive.dart';

class ListNotices extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ListNoticesState();
}

class ListNoticesState extends State<ListNotices> {
  List<Noticias> noticias = Noticias.noticias_album();
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: Container(
          alignment: Alignment.center,
          child: Row(
            children: [
              Text("Usuario"),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Container(
          padding: EdgeInsets.all(10),
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
              Text(
                "Noticias",
                style: TextStyle(
                    fontSize: responsive.diagonalPorcentaje(5),
                    color: Color.fromRGBO(255, 226, 199, 1),
                    fontWeight: FontWeight.bold),
              ),
              Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: noticias.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Dismissible(
                          key: ObjectKey(noticias[index]),
                          child: CardNotices(noticias[index]),
                          onDismissed: (direction) {
                            setState(() {
                              noticias.removeAt(index);
                            });
                          },
                        );
                      }),
                ],
              )
            ],

            //),
          ),
        ),
      ),
    );
  }
}

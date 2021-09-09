import 'package:flutter/material.dart';
import 'package:pasantia_noticias/model/NoticiaM.dart';
import 'package:pasantia_noticias/pages/login/noticiasInformacion.dart';

class CardNotices extends StatelessWidget {
  NoticiaM noticias;
  CardNotices(this.noticias);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        height: 150,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => new NoticiasInformacion(),
              ),
            );
          },
          child: Card(
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                padding(Text(noticias.categoriaNoticia,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(255, 226, 199, 1)))),
                // Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // children: [
                //padding(Icon(Icons.check)),
                //padding(Text(noticias.name, style: TextStyle(fontSize: 10))),
                Column(
                  children: [
                    Text(
                      noticias.tituloNoticia,
                      style: TextStyle(
                          decorationThickness: 3,
                          height: 2,
                          color: Color.fromRGBO(255, 226, 199, 1)),
                      maxLines: 3,
                    ),
                  ],
                )
                //  ],
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget padding(Widget widget) {
    return Padding(
      padding: EdgeInsets.all(7.0),
      child: widget,
    );
  }
}

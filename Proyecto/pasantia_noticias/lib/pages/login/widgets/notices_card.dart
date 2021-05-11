import 'package:flutter/material.dart';
import 'package:pasantia_noticias/pages/login/noticiasInformacion.dart';
import 'package:pasantia_noticias/pages/login/widgets/notices.dart';

class CardNotices extends StatelessWidget {
  Noticias noticias;
  CardNotices(this.noticias);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(noticias.image),
          fit: BoxFit.cover,
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.6), BlendMode.dstATop),
        )),
        height: 150,
        child: InkWell(
          onTap: () {
            print(noticias.categoria);
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => new NoticiasInformacion(noticias),
              ),
            );
          },
          child: Card(
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                padding(Text(noticias.titulo,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black))),
                // Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // children: [
                //padding(Icon(Icons.check)),
                //padding(Text(noticias.name, style: TextStyle(fontSize: 10))),
                Column(
                  children: [
                    Text(
                      'un texto' * 10,
                      style: TextStyle(
                          decorationThickness: 3,
                          height: 2,
                          color: Colors.black),
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

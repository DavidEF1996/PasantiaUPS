import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pasantia_noticias/pages/login/widgets/notices.dart';
import 'package:pasantia_noticias/pages/login/widgets/notices_card.dart';

class ListNotices extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ListNoticesState();
}

class ListNoticesState extends State<ListNotices> {
  List<Noticias> noticias = Noticias.noticias_album();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        children: [
          Text(
            "Noticias",
            style: TextStyle(fontSize: 15, color: Colors.black),
          ),
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
      ),
    );
  }
}

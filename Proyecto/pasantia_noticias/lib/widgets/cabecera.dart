import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pasantia_noticias/services/Preferencias.dart';
import 'package:pasantia_noticias/utils/responsive.dart';

class Cabecera extends StatelessWidget {
  const Cabecera({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    final _preferences = new Preferences();

    final Responsive responsive = Responsive.of(context);
    if (data.orientation == Orientation.portrait) {
      return Container(
          padding: EdgeInsets.all(responsive.diagonalPorcentaje(1)),
          child: Text.rich(
            TextSpan(
                text: "Usuario: ",
                style: TextStyle(
                  fontSize: responsive.diagonalPorcentaje(2.1),
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(18, 69, 122, 1),
                ),
                children: <InlineSpan>[
                  TextSpan(
                      text: utf8.decode(latin1.encode(_preferences.nombres),
                          allowMalformed: true),
                      style: TextStyle(
                          fontSize: responsive.diagonalPorcentaje(2),
                          color: Colors.black))
                ]),
          ));
    } else {
      return Container(
          child: Text.rich(
        TextSpan(
            text: "Usuario: ",
            style: TextStyle(
              fontSize: responsive.diagonalPorcentaje(3.5),
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(18, 69, 122, 1),
            ),
            children: <InlineSpan>[
              TextSpan(
                  text: utf8.decode(latin1.encode(_preferences.nombres),
                      allowMalformed: true),
                  style: TextStyle(
                      fontSize: responsive.diagonalPorcentaje(3),
                      color: Colors.black))
            ]),
      ));
    }
  }
}

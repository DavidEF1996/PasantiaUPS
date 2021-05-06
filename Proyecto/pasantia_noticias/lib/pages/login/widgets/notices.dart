import 'dart:ui';

import 'package:flutter/material.dart';

class Noticias {
  String title;
  String name;
  Color color;

  Noticias(this.title, this.name, this.color);

  static List<Noticias> noticias_album() {
    return [
      Noticias(
          "Tema de Titulación",
          "Producto informático para el Programa de Asesoramiento Empresarial",
          Colors.black),
      Noticias("Oferta laboral",
          "Physeter SA necesita estudiantes para pasantías", Colors.black),
      Noticias("Horarios de Examenes", "Este es el horario de exámenes para...",
          Colors.black)
    ];
  }
}

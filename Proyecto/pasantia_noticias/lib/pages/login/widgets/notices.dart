import 'dart:ui';

import 'package:flutter/material.dart';

class Noticias {
  String title;
  String name;
  Color color;
  String image;
  String fecha;

  Noticias(this.title, this.name, this.color, this.image, this.fecha);

  static List<Noticias> noticias_album() {
    return [
      Noticias(
          "Tema de Titulación",
          "Producto informático para el Programa de Asesoramiento Empresarial",
          Colors.black,
          "assets/titulacion.jpg", "10/05/2021"),
      Noticias(
          "Oferta laboral",
          "Physeter SA necesita estudiantes para pasantías",
          Colors.black,
          "assets/ofertaLaboral.jpg", "10/05/2021"),
      Noticias("Horarios de Examenes", "Este es el horario de exámenes para...",
          Colors.black, "assets/titulacion.jpg", "10/05/2021")
    ];
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pasantia_noticias/utils/responsive.dart';

class BotonRegresar extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  const BotonRegresar({Key key, @required this.onPressed, @required this.label})
      : assert(label != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Container(
      child: CupertinoButton(
        child: Container(
          width: responsive.diagonalPorcentaje(10),
          child: Icon(
            Icons.arrow_back,
            size: 65,
            color: Color.fromRGBO(255, 186, 0, 1),
          ),
        ),
        onPressed: this.onPressed,
      ),
    );
  }
}

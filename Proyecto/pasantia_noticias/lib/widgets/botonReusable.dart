import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BotonReusable extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  const BotonReusable({Key key, @required this.onPressed, @required this.label})
      : assert(label != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: Container(
        child: Text(
          this.label,
          style: TextStyle(
              color: Color.fromRGBO(28, 26, 24, 1),
              fontFamily: 'sans',
              letterSpacing: 1,
              fontSize: 25),
        ),
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
        decoration: BoxDecoration(
            color: Color.fromRGBO(255, 186, 0, 0.85),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)]),
      ),
      onPressed: this.onPressed,
    );
  }
}

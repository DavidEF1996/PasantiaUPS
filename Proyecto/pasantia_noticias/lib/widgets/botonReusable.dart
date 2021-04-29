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
              color: Colors.black,
              fontFamily: 'sans',
              letterSpacing: 1,
              fontSize: 25),
        ),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)]),
      ),
      onPressed: () {},
    );
  }
}

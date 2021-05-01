import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InputTextFormulario extends StatelessWidget {
  final String iconosPath;
  final String placeHolder;
  const InputTextFormulario(
      {Key key, @required this.iconosPath, @required this.placeHolder})
      : assert(iconosPath != null && placeHolder != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      prefix: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
        ),
        padding: EdgeInsets.all(2),
        child: SvgPicture.asset(
          this.iconosPath,
          height: 40,
        ),
      ),
      placeholder: this.placeHolder,
      style: TextStyle(fontFamily: 'sans', color: Colors.black, fontSize: 16),
      placeholderStyle: TextStyle(
          fontFamily: 'sans', color: Colors.blueGrey[700], fontSize: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0,
            color: Color(0xffdddddd),
          ),
        ),
      ),
    );
  }
}

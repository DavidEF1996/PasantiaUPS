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
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      prefix: Container(
        padding: EdgeInsets.all(2),
        width: 40,
        height: 30,
        child: SvgPicture.asset(
          this.iconosPath,
        ),
      ),
      placeholder: this.placeHolder,
      style: TextStyle(fontFamily: 'sans'),
      placeholderStyle: TextStyle(fontFamily: 'sans', color: Color(0xffcccccc)),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Color(0xffdddddd),
          ),
        ),
      ),
    );
  }
}

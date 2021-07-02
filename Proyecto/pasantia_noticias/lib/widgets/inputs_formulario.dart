import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InputTextFormulario extends StatefulWidget {
  final String iconosPath;
  final String placeHolder, initValue;
  final bool Function(String text) validator;
  final usuario;
  const InputTextFormulario(
      {Key key,
      @required this.iconosPath,
      @required this.placeHolder,
      @required this.usuario,
      this.validator,
      this.initValue = ''})
      : assert(iconosPath != null && placeHolder != null),
        super(key: key);

  @override
  _InputTextFormularioState createState() => _InputTextFormularioState();
}

class _InputTextFormularioState extends State<InputTextFormulario> {
  TextEditingController _controller;
  bool _validationOk = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.usuario);

    _checkValidation();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _checkValidation() {
    if (widget.validator != null) {
      final isOk = widget.validator(_controller.text);
      if (_validationOk != isOk) {
        setState(() {
          _validationOk = isOk;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      onChanged: (text) => _checkValidation(),
      controller: _controller,
      decoration: BoxDecoration(color: Colors.white),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      prefix: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
        ),
        padding: EdgeInsets.all(2),
        child: SvgPicture.asset(
          this.widget.iconosPath,
          height: 40,
        ),
      ),
      suffix: widget.validator != null
          ? Icon(Icons.check_circle,
              color: _validationOk ? Colors.blue : Colors.red)
          : null,
      placeholder: this.widget.placeHolder,
      style: TextStyle(fontFamily: 'sans', color: Colors.black, fontSize: 16),
      placeholderStyle:
          TextStyle(fontFamily: 'sans', color: Colors.black, fontSize: 16),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pasantia_noticias/utils/ValidacionesGlobales.dart';

class InputTextNomApe extends StatefulWidget {
  final String iconosPath;
  final String placeHolder, initValue;
  final bool Function(String text) validator;
  final usuario;
  const InputTextNomApe(
      {Key key,
      @required this.iconosPath,
      @required this.placeHolder,
      @required this.usuario,
      this.validator,
      this.initValue = ''})
      : assert(iconosPath != null && placeHolder != null),
        super(key: key);

  @override
  _InputTextNomApeState createState() => _InputTextNomApeState();
}

class _InputTextNomApeState extends State<InputTextNomApe> {
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
    final isOk = widget.validator(_controller.text);

    String recibir = validateName(_controller.text);
    if (recibir == null) {
      if (_validationOk != isOk) {
        setState(() {
          _validationOk = isOk;
          ValidacionesGlobales.validarNombre = true;
        });
      }
    } else {
      setState(() {
        _validationOk = false;
        ValidacionesGlobales.validarNombre = false;
      });
    }
    //   }
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "El correo es necesario";
    } else if (!regExp.hasMatch(value)) {
      return "Correo invalido";
    } else {
      return null;
    }
  }

  String validateName(String value) {
    //String pattern = r"[ 0-9A-Za-zñÑáéíóúÁÉÍÓÚ¡!¿?@#$%()=+-€/.,]{1,50}";
    String pattern = r'(^[a-zA-Z-ñÑáéíóúÁÉÍÓÚ ]*$)';
    List<String> recibir = value.split(" ");

    RegExp regExp = new RegExp(pattern);

    if (value.length == 0) {
      return "El campo es necesario";
    } else if (recibir.length < 2) {
      return "No puede estar solo un numero";
    } else if (!regExp.hasMatch(value)) {
      return "El campo debe contener solo letras";
    }

    if (recibir[1] == "") {
      return "Falta el segundo nombre";
    } else {
      return null;
    }
  }

  bool validarCedula(String cedula) {
    int digito = -1;
    int suma = 0;
    int resta = -1;

    for (int i = 0; i < cedula.length; i++) {
      digito = cedula.codeUnitAt(i) - 48;
      if (i % 2 == 0) digito = (digito * 2) > 9 ? (digito * 2) - 9 : digito * 2;

      if (i < cedula.length - 1) suma += digito;
    }
    suma = suma % 10;
    resta = (digito == 0) ? suma : 10 - suma;
    return (resta == digito);
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
          TextStyle(fontFamily: 'sans', color: Colors.black, fontSize: 12.5),
    );
  }
}

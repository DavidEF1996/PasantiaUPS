import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonDisable extends StatefulWidget {
  @override
  _ButtonDisableState createState() => _ButtonDisableState();
}

class _ButtonDisableState extends State<ButtonDisable> {
  bool isButtonClickable = true;

  void OcultarBoton() async {
    Duration time = Duration(seconds: 5);
    setState(() {
      isButtonClickable = false;

      Future.delayed(time, () {
        setState(() {
          isButtonClickable = true;
        });
      });
    });
  }

  void ocultarBoton() {
    setState(() {
      isButtonClickable = false;
    });
  }

  void mostrarBoton() {
    setState(() {
      isButtonClickable = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: isButtonClickable,
              child: ElevatedButton(
                onPressed: () {
                  if (isButtonClickable) {
                    ocultarBoton();
                  }
                },
                child: Text(
                  isButtonClickable ? "Clickable" : "Not Clickable",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

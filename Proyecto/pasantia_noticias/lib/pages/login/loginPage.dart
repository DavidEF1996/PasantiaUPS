import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pasantia_noticias/widgets/login_form.dart';
import 'package:pasantia_noticias/widgets/welcome.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment(0.7, 0), // 10% of the width, so there are ten blinds.
          colors: [
            const Color.fromRGBO(28, 26, 24, 1),
            const Color.fromRGBO(28, 26, 24, 1),
          ], // red to yellow
          tileMode: TileMode.repeated, // repeats the gradient over the canvas
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment(0.7, 0.5),
                      colors: [
                        const Color.fromRGBO(255, 226, 199, 1),
                        const Color.fromRGBO(255, 186, 0, 1),
                      ], // red to yellow
                      tileMode: TileMode
                          .repeated, // repeats the gradient over the canvas
                    ),
                  ),
                  child: Welcome(),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromRGBO(101, 91, 80, 0.7),
                  ),
                  padding: EdgeInsets.all(19),
                  child: LoginForm(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

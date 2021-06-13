import 'package:flutter/material.dart';
import 'package:pasantia_noticias/pages/login/Administracion.dart';
import 'package:pasantia_noticias/pages/login/loginPage.dart';
import 'package:pasantia_noticias/pages/login/widgets/ListNotices.dart';
import 'package:pasantia_noticias/pages/login/widgets/PrincipalNoticias.dart';
import 'package:pasantia_noticias/pages/login/widgets/notices_card.dart';
import 'package:pasantia_noticias/pages/login/widgets/paginador.dart';
import 'package:pasantia_noticias/services/Preferencias.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final _preferences = new Preferences();
  await _preferences.initPreferences();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final _preferences = new Preferences();
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        fontFamily: 'sans',
      ),
      // home: ListNotices(),
      //home: LoginPage()
      home: (_preferences.id == "") ? LoginPage() : PrincipalNoticias(),
    );
  }
}

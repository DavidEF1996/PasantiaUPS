import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pasantia_noticias/pages/login/loginPage.dart';
import 'package:pasantia_noticias/pages/login/widgets/PrincipalNoticias.dart';
import 'package:pasantia_noticias/services/FireBaseNotificaciones.dart';
import 'package:pasantia_noticias/services/Preferencias.dart';
import 'package:pasantia_noticias/utils/contadorProvider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initializeApp();
  final _preferences = new Preferences();
  await _preferences.initPreferences();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messengerKey =
      new GlobalKey<ScaffoldMessengerState>();
  @override
  void initState() {
    super.initState();
    PushNotificationService.messageStream.listen((message) {
      print('MyApp: $message');
      RemoteMessage message1;

      if (PushNotificationService.abrir == true) {
        navigatorKey.currentState?.pushNamed('emergencias', arguments: message);
      }

      final snackBar = SnackBar(content: Text(message));
      messengerKey.currentState?.showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    final _preferences = new Preferences();
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey, //NAVEGAR
      scaffoldMessengerKey: messengerKey, //MOSTRAR SNACKS
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
      routes: {
        'emergencias': (_) => PrincipalNoticias(
              categoriaEnviar: "emergencias",
            ),
      },
      home: (_preferences.id == "") ? PrincipalNoticias() : LoginPage(),
    );
  }
}

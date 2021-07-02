import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pasantia_noticias/model/NoticiaM.dart';
import 'package:pasantia_noticias/pages/login/loginPage.dart';
import 'package:pasantia_noticias/pages/login/noticiasInformacion.dart';
import 'package:pasantia_noticias/pages/login/widgets/PrincipalGenerales.dart';
import 'package:pasantia_noticias/services/FireBaseNotificaciones.dart';
import 'package:pasantia_noticias/services/Preferencias.dart';
import 'package:pasantia_noticias/services/ServicioListarNoticias.dart';
import 'package:pasantia_noticias/utils/rutas.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final _preferences = new Preferences();
  await _preferences.initPreferences();

  //print(_preferences.nombres);

  await PushNotificationService.initializeApp();

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
    int cont = 0;
    int contadorEmergencias = 0;
    int contadorNoticias = 0;
    int contadorOfertasCursos = 0;
    int contadorOfertasLaborales = 0;

    PushNotificationService.messageStream.listen((message) {
      List categorias = [];
      print('MyApp: $message');

      categorias = message.split(' ');

      final _preferences = new Preferences();
      print(categorias[0].toString());

      _preferences.idNoticias = categorias[1]; //este es el titulo
      _preferences.categorias = categorias[0].toString().toLowerCase();

      cont = _preferences.numeroNoticia + 1;
      _preferences.numeroNoticia = cont;
      if (categorias[0].toString().toLowerCase() == "emergencias") {
        contadorEmergencias++;
        _preferences.noticia1 = contadorEmergencias;
      } else if (categorias[0].toString().toLowerCase() == "noticias") {
        contadorNoticias++;
        _preferences.noticia2 = contadorNoticias;
      } else if (categorias[0].toString().toLowerCase() == "ofertaslaborales") {
        contadorOfertasLaborales++;
        _preferences.noticia3 = contadorOfertasLaborales;
      } else if (categorias[0].toString().toLowerCase() == "ofertascursos") {
        contadorOfertasCursos++;
        _preferences.noticia4 = contadorOfertasCursos;
      }

      /* if (cont == 0) {
        _preferences.noticia1 = 0;
      } else if (cont == 1) {
        _preferences.noticia2 = 0;
        _preferences.noticia1 = 1;
      } else if (cont == 2) {
        _preferences.noticia3 = 0;
        _preferences.noticia2 = 1;
        _preferences.noticia1 = 2;
      }*/

      if (PushNotificationService.abrir == true) {
        /*List<NoticiaM> datos = [];
        Future<void> llenar() async {
          datos = await ListaNoticias.getNoticias("emergencias");
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (context) => new NoticiasInformacion(datos[0]),
            ),
          );
        }*/

        navigatorKey.currentState?.pushNamed('message', arguments: message);
      }

      final snackBar = SnackBar(
          content: Text("Nueva notificacion: " +
              _preferences.idNoticias.toString().toUpperCase()));
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
        primarySwatch: Colors.yellow,

        fontFamily: 'sans',
      ),
      // home: ListNotices(),
      //home: LoginPage()
      routes: builAppRoutes(),
      home: (_preferences.id == "") ? LoginPage() : PrincipalNo(),
    );
  }
}

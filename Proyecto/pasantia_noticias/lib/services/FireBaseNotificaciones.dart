//B0:14:BE:08:B0:02:FE:54:BC:B6:99:F6:FF:88:4C:26:FE:A5:B4:90
import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String token;
  static bool abrir = false;
  //variable para que este escuchando
  static StreamController<String> _messageStreamController =
      new StreamController.broadcast();
  static Stream<String> get messageStream => _messageStreamController.stream;

  static Future _backgroundHandler(RemoteMessage message) async {
    //print('Background Handler ${message.messageId}');
    //_messageStreamController
    // .add(message.notification?.title ?? 'No tiene titulo');
    print(message.data);
    _messageStreamController.add(
        message.data['categoria'] + " " + message.data['contenido'] ??
            'No tiene informacion');
    abrir = true;
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    //print('onMessage Handler ${message.messageId}');
    // _messageStreamController
    // .add(message.notification?.title ?? 'No tiene titulo');
    print(message.data);
    _messageStreamController.add(
        message.data['categoria'] + " " + message.data['contenido'] ??
            'No tiene informacion');
    abrir = false;
  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    //print('onMessageOpenApp Handler ${message.messageId}');
    //_messageStreamController
    //   .add(message.notification?.title ?? 'No tiene titulo');
    print(message.data);
    _messageStreamController.add(
        message.data['categoria'] + " " + message.data['contenido'] ??
            'No tiene informacion');
    abrir = true;
  }

  static Future initializeApp() async {
    //Notificaciones push

    await Firebase.initializeApp();

    token = await FirebaseMessaging.instance.getToken();
    print("El token es: " + token.toString());

    //Hnadlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_backgroundHandler);

    //Noticicaciones locales
  }

  static closeStream() {
    _messageStreamController.close();
  }
}

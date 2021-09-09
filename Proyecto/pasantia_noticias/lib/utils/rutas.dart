import 'package:flutter/cupertino.dart';
import 'package:pasantia_noticias/pages/login/noticiasInformacion2.dart';

Map<String, WidgetBuilder> builAppRoutes() {
  return {
    // 'informacion': (BuildContext context) => new NoticiasInformacion(datos[0]),
    'message': (BuildContext context) => new NoticiasInformacion2(),
    'admin': (BuildContext context) => new NoticiasInformacion2()
  };
}

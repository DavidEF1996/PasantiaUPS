import 'package:flutter/cupertino.dart';
import 'package:pasantia_noticias/model/NoticiaM.dart';
import 'package:pasantia_noticias/pages/login/Administracion.dart';
import 'package:pasantia_noticias/pages/login/noticiasInformacion.dart';
import 'package:pasantia_noticias/pages/login/noticiasInformacion2.dart';
import 'package:pasantia_noticias/pages/login/widgets/PrincipalEmergencias.dart';
import 'package:pasantia_noticias/pages/login/widgets/paginador.dart';
import 'package:pasantia_noticias/services/ServicioListarNoticias.dart';

Map<String, WidgetBuilder> builAppRoutes() {
  return {
    // 'informacion': (BuildContext context) => new NoticiasInformacion(datos[0]),
    'message': (BuildContext context) => new NoticiasInformacion2(),
    'admin': (BuildContext context) => new NoticiasInformacion2()
  };
}



import 'package:flutter/cupertino.dart';
import 'package:pasantia_noticias/pages/login/widgets/ListNotices.dart';

Map<String, WidgetBuilder> builAppRoutes() {
  return {
    '/noticiasgenerales': (BuildContext context) => new ListNotices(),
    
  };
}


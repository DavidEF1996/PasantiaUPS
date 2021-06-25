import 'package:flutter/material.dart';
import 'package:pasantia_noticias/utils/contadorProvider.dart';

import 'package:provider/provider.dart';

class Contador extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<Counter>(context);
    return Container(
      child: Text('${counter.count}'),
    );
  }
}

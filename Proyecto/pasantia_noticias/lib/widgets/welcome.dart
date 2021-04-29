import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pasantia_noticias/utils/responsive.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Container(
      child: AspectRatio(
        aspectRatio: 16 / 10,
        child: LayoutBuilder(builder: (_, contraints) {
          return Container(
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: contraints.maxHeight * 0.05,
                  right: 10,
                  child: Image(image: AssetImage('assets/logo.png')),
                  width: contraints.maxWidth,
                  height: contraints.maxHeight * 0.7,
                ),
                Positioned(
                  top: contraints.maxHeight * 0.60,
                  child: SvgPicture.asset('assets/Chica.svg'),
                  width: contraints.maxWidth * 0.3,
                  height: contraints.maxHeight * 0.4,
                ),
                Positioned(
                    top: contraints.maxHeight * 0.75,
                    child: Column(
                      children: [
                        Text(
                          "Bienvenido",
                          style: TextStyle(
                              fontFamily: 'raleway',
                              fontSize: responsive.diagonalPorcentaje(3),
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          height: 3,
                          width: contraints.maxWidth,
                          color: Color(0xffeeeeeee),
                        ),
                      ],
                    )),
              ],
            ),
          );
        }),
      ),
    );
  }
}

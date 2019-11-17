import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Logo extends StatelessWidget {
  final double size;

  const Logo({
    Key key,
    this.size = 40.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Hero(
          tag: 'logo',
          child: Icon(
            FontAwesomeIcons.penFancy,
            size: size,
          ),
        ),
        SizedBox(
          width: 5.0,
        ),
        Text(
          'Inkly',
          style: TextStyle(
            fontSize: size + 5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

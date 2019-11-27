import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  final String assetName;
  final Color color;
  final double size;
  final EdgeInsetsGeometry padding;
  final void Function() onPressed;

  const ImageButton({
    Key key,
    @required this.assetName,
    this.color,
    this.onPressed,
    this.size = 40.0,
    this.padding = const EdgeInsets.all(8.0),
  })  : assert(assetName != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      padding: padding,
      minWidth: 0,
      height: 0,
      child: Container(
        height: size,
        width: size,
        child: Image.asset(
          assetName,
          color: color,
          fit: BoxFit.contain,
        ),
      ),
      onPressed: onPressed,
    );
  }
}

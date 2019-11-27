import 'package:flutter/material.dart';

class TopCornerIconButton extends StatelessWidget {
  final IconData icon;

  const TopCornerIconButton({
    Key key,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: Theme.of(context).primaryColor,
      size: 25.0,
    );
  }
}
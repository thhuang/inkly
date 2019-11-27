import 'package:flutter/material.dart';

class TopCornerIconButton extends StatelessWidget {
  final IconData icon;
  final void Function() onPressed;

  const TopCornerIconButton({
    Key key,
    this.icon,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Icon(
        icon,
        color: Theme.of(context).primaryColor,
        size: 25.0,
      ),
    );
  }
}

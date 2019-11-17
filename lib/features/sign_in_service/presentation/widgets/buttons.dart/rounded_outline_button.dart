import 'package:flutter/material.dart';

class RoundedOutlineButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final void Function() onPressed;

  const RoundedOutlineButton({
    Key key,
    this.child,
    @required this.onPressed,
    this.color = Colors.black26,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      child: child,
      onPressed: onPressed,
      highlightedBorderColor: Theme.of(context).highlightColor,
      borderSide: BorderSide(color: color),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100.0),
      ),
    );
  }
}

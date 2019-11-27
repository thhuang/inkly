import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final List<Widget> children;
  final Color color;

  const CustomBottomNavigationBar({
    Key key,
    this.children,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: children ?? <Widget>[SizedBox(height: 60.0)],
      ),
      shape: CircularNotchedRectangle(),
      color: color ?? Theme.of(context).scaffoldBackgroundColor,
    );
  }
}

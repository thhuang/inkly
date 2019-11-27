import 'package:flutter/material.dart';

class RoundModalBottomSheet extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color color;

  const RoundModalBottomSheet({
    Key key,
    this.child,
    this.padding,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: padding,
        child: Container(
          decoration: BoxDecoration(
            color: color ?? Theme.of(context).cardColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                child: Container(
                  height: 4.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.all(Radius.circular(100.0)),
                  ),
                ),
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> showRoundModalBottomSheet({
  @required context,
  padding,
  child,
  color,
  isScrollControlled = true,
}) async {
  await showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    isScrollControlled: isScrollControlled,
    builder: (context) => RoundModalBottomSheet(
      padding: padding,
      child: child,
      color: color,
    ),
  );
}

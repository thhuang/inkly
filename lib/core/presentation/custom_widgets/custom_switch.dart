import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:xlive_switch/xlive_switch.dart';

class CustomSwitch extends StatelessWidget {
  final bool _value;
  final void Function(bool) onChanged;
  final Color activeColor;
  final DragStartBehavior dragStartBehavior;

  const CustomSwitch({
    Key key,
    @required value,
    @required this.onChanged,
    this.activeColor,
    this.dragStartBehavior = DragStartBehavior.start,
  })  : assert(value != null),
        _value = value,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return XlivSwitch(
      onChanged: onChanged,
      value: _value,
      activeColor: activeColor,
      unActiveColor: Colors.black26,
    );
  }
}

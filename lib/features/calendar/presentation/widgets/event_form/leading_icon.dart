import 'package:flutter/material.dart';

import 'utils/constants.dart';

class LeadingIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  const LeadingIcon({
    Key key,
    this.icon,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: LEADING_ICON_WIDTH,
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: color,
            size: ICON_SIZE,
          ),
        ],
      ),
    );
  }
}

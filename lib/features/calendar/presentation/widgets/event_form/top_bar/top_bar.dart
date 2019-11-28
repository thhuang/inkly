import 'package:flutter/material.dart';

import 'clear_adding_event_button.dart';
import 'done_adding_event_button.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(width: 10.0),
        ClearAddingEventButton(),
        Expanded(child: Container()),
        DoneAddingEventButton(),
        SizedBox(width: 10.0),
      ],
    );
  }
}

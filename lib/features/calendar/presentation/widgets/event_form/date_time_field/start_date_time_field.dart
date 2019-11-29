import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import '../../../logicholders/date_time_field_state_notifier.dart';
import '../../../logicholders/event_notifier.dart';
import 'date_time_selector/date_time_selector.dart';

class StartDateTimeField extends StatelessWidget {
  const StartDateTimeField({
    Key key,
  }) : super(key: key);

  void _onDateTimeChanged(
    DateTimeFieldStateNotifier state,
    EventNotifier event,
    DateTime value,
  ) {
    var difference = event.event.endDateTime.difference(
      event.event.startDateTime,
    );
    event.updateEventFields(
      startDateTime: value,
      endDateTime: value.add(difference),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<DateTimeFieldStateNotifier, EventNotifier>(
      builder: (_, state, event, __) {
        return DateTimeSelector(
          icon: LineIcons.caret_right,
          dateTime: event.event.startDateTime,
          onDateTimeChanged: (value) => _onDateTimeChanged(state, event, value),
          isSelected: state.startFieldSelected,
          onClicked: () => state.startFieldSelected = !state.startFieldSelected,
        );
      },
    );
  }
}

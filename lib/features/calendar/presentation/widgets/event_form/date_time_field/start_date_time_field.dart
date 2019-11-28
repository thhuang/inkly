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

  @override
  Widget build(BuildContext context) {
    return Consumer2<EventNotifier, DateTimeFieldStateNotifier>(
      builder: (_, event, state, __) {
        return DateTimeSelector(
          icon: LineIcons.caret_right,
          dateTime: event.event.startDateTime,
          onDateTimeChanged: (DateTime value) {
            var difference = event.event.endDateTime.difference(
              event.event.startDateTime,
            );
            event.updateEventFields(
              startDateTime: value,
              endDateTime: value.add(difference),
            );
          },
          isSelected: state.startFieldSelected,
          onClicked: () => state.startFieldSelected = !state.startFieldSelected,
        );
      },
    );
  }
}

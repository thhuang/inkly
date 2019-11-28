import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import '../../../logicholders/date_time_field_state_notifier.dart';
import '../../../logicholders/event_notifier.dart';
import 'date_time_selector/date_time_selector.dart';

class EndDateTimeField extends StatelessWidget {
  const EndDateTimeField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<EventNotifier, DateTimeFieldStateNotifier>(
      builder: (_, event, state, __) {
        return DateTimeSelector(
          icon: LineIcons.caret_left,
          dateTime: event.event.endDateTime,
          minimumDateTime: event.event.startDateTime,
          onDateTimeChanged: (DateTime value) {
            if (value.isBefore(event.event.startDateTime)) {
              event.updateEventFields(startDateTime: value, endDateTime: value);
            } else {
              event.updateEventFields(endDateTime: value);
            }
          },
          isSelected: state.endFieldSelected,
          onClicked: () => state.endFieldSelected = !state.endFieldSelected,
        );
      },
    );
  }
}

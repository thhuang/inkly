import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/presentation/custom_widgets/custom_switch.dart';
import '../../../logicholders/date_time_field_state_notifier.dart';
import '../../../logicholders/event_notifier.dart';
import '../leading_icon.dart';
import '../utils/constants.dart';

class AllDayField extends StatelessWidget {
  const AllDayField({
    Key key,
  }) : super(key: key);

  void _onAllDayChanged(
    DateTimeFieldStateNotifier state,
    EventNotifier event,
    bool value,
  ) {
    state.allDay = value;
    event.updateEventFields(
      allDay: value,
      startDateTime: event.event.startDateTime.subtract(
        Duration(
          hours: event.event.startDateTime.hour,
          minutes: event.event.startDateTime.minute,
        ),
      ),
      endDateTime: event.event.endDateTime.subtract(
        Duration(
          hours: event.event.endDateTime.hour,
          minutes: event.event.endDateTime.minute,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<DateTimeFieldStateNotifier, EventNotifier>(
      builder: (_, state, event, __) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: FIELD_HEIGHT),
            LeadingIcon(
              icon: LineIcons.calendar,
              color: state.allDay
                  ? Theme.of(context).primaryColor
                  : Colors.black38,
            ),
            Text(
              'All-day',
              style: TextStyle(
                color: state.allDay ? Colors.black : Colors.black38,
                fontSize: TEXT_SIZE,
              ),
            ),
            Expanded(child: Container()),
            CustomSwitch(
              onChanged: (value) => _onAllDayChanged(state, event, value),
              value: state.allDay,
              activeColor: Theme.of(context).primaryColor,
            )
          ],
        );
      },
    );
  }
}

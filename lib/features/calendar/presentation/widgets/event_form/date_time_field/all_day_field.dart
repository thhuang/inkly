import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inkly/features/calendar/presentation/logicholders/date_time_field_state_notifier.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/presentation/custom_widgets/custom_switch.dart';
import '../leading_icon.dart';
import '../utils/constants.dart';

class AllDayField extends StatelessWidget {
  const AllDayField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DateTimeFieldStateNotifier>(
      builder: (_, state, __) {
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
              onChanged: (value) => state.allDay = value,
              value: state.allDay,
              activeColor: Theme.of(context).primaryColor,
            )
          ],
        );
      },
    );
  }
}

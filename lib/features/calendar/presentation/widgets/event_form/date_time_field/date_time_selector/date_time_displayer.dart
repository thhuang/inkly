import 'package:date_format/date_format.dart' as dateFormat;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../logicholders/date_time_field_state_notifier.dart';
import '../../leading_icon.dart';
import '../../utils/constants.dart';

class DateTimeDisplayer extends StatelessWidget {
  final DateTime _dateTime;
  final IconData icon;

  const DateTimeDisplayer({
    Key key,
    @required dateTime,
    this.icon,
  })  : assert(dateTime != null),
        _dateTime = dateTime,
        super(key: key);

  String _generateShortDateText(DateTime dateTime) {
    return dateFormat.formatDate(dateTime, [
      dateFormat.D,
      ', ',
      dateFormat.M,
      ' ',
      dateFormat.d,
    ]);
  }

  String _generateLongDateText(DateTime dateTime) {
    return dateFormat.formatDate(dateTime, [
      dateFormat.DD,
      ', ',
      dateFormat.MM,
      ' ',
      dateFormat.d,
    ]);
  }

  String _generateTimeText(DateTime dateTime) {
    return dateFormat.formatDate(dateTime, [
      dateFormat.h,
      ':',
      dateFormat.nn,
      ' ',
      dateFormat.am,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(height: FIELD_HEIGHT),
        SizedBox(width: LEADING_ICON_WIDTH),
        LeadingIcon(icon: icon),
        Expanded(
          child: Consumer<DateTimeFieldStateNotifier>(
            builder: (_, state, __) {
              return DefaultTextStyle.merge(
                style: TextStyle(fontSize: TEXT_SIZE),
                child: Row(
                  children: <Widget>[
                    state.allDay
                        ? Text(_generateLongDateText(_dateTime))
                        : Text(_generateShortDateText(_dateTime)),
                    Expanded(child: Container()),
                    if (!state.allDay) Text(_generateTimeText(_dateTime)),
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(width: LEADING_ICON_WIDTH),
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../logicholders/date_time_field_state_notifier.dart';
import '../../utils/constants.dart';

class DateTimePicker extends StatelessWidget {
  final DateTime minimumDate;
  final DateTime initialDateTime;
  final void Function(DateTime) onDateTimeChanged;

  const DateTimePicker({
    Key key,
    @required this.onDateTimeChanged,
    this.initialDateTime,
    this.minimumDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.0,
      child: CupertinoTheme(
        data: CupertinoThemeData(
          textTheme: CupertinoTextThemeData(
            dateTimePickerTextStyle: TextStyle(
              fontSize: TEXT_SIZE,
            ),
          ),
        ),
        child: CupertinoDatePicker(
          initialDateTime: initialDateTime,
          onDateTimeChanged: onDateTimeChanged,
          minimumDate: minimumDate,
          minuteInterval: MINUTE_INTERVAL,
          mode: Provider.of<DateTimeFieldStateNotifier>(context).allDay
              ? CupertinoDatePickerMode.date
              : CupertinoDatePickerMode.dateAndTime,
        ),
      ),
    );
  }
}

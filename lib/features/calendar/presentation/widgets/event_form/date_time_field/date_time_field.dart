import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../logicholders/date_time_field_state_notifier.dart';
import 'all_day_field.dart';
import 'end_date_time_field.dart';
import 'start_date_time_field.dart';

class DateTimeField extends StatelessWidget {
  const DateTimeField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DateTimeFieldStateNotifier>(
      builder: (_) => DateTimeFieldStateNotifier(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 5.0),
            AllDayField(),
            StartDateTimeField(),
            EndDateTimeField(),
          ],
        ),
      ),
    );
  }
}

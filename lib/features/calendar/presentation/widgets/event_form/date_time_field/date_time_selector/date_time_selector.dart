import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inkly/features/calendar/presentation/widgets/event_form/utils/constants.dart';

import 'date_time_displayer.dart';
import 'date_time_picker.dart';

class DateTimeSelector extends StatelessWidget {
  final IconData icon;
  final DateTime _dateTime;
  final DateTime minimumDateTime;
  final bool _isSelected;
  final void Function(DateTime) _onDateTimeChanged;
  final void Function() onClicked;

  const DateTimeSelector({
    Key key,
    @required DateTime dateTime,
    @required onDateTimeChanged,
    this.minimumDateTime,
    isSelected = false,
    this.onClicked,
    this.icon,
  })  : assert(dateTime != null),
        assert(onDateTimeChanged != null),
        assert(isSelected != null),
        _dateTime = dateTime,
        _onDateTimeChanged = onDateTimeChanged,
        _isSelected = isSelected,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: onClicked,
          child: DateTimeDisplayer(
            icon: icon,
            dateTime: _dateTime,
          ),
        ),
        if (_isSelected)
          DateTimePicker(
            minimumDate: minimumDateTime == null
                ? null
                : minimumDateTime.subtract(Duration(days: 1)),
            initialDateTime: _dateTime.minute % MINUTE_INTERVAL == 0
                ? _dateTime
                : _dateTime.subtract(Duration(minutes: _dateTime.minute)),
            onDateTimeChanged: _onDateTimeChanged,
          ),
      ],
    );
  }
}

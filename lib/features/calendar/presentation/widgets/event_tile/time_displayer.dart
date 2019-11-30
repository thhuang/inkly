import 'package:date_format/date_format.dart' as dateFormat;
import 'package:flutter/material.dart';

import '../../../domain/entities/event.dart';
import '../event_form/utils/constants.dart';

class TimeDisplayer extends StatelessWidget {
  final DateTime dayStartTime;
  final DateTime dayEndTime;
  final Event event;

  const TimeDisplayer({
    Key key,
    @required this.dayStartTime,
    @required this.dayEndTime,
    @required this.event,
  }) : super(key: key);

  DateTime _getStartTime() => dayStartTime.isAfter(event.startDateTime)
      ? dayStartTime
      : event.startDateTime;

  DateTime _getEndTime() =>
      dayEndTime.isBefore(event.endDateTime) ? dayEndTime : event.endDateTime;

  String _getGeneralTimeFormatString(DateTime dateTime) =>
      dateFormat.formatDate(
        dateTime,
        USE_24_BASED_HOUR
            ? [dateFormat.H, ':', dateFormat.nn]
            : [dateFormat.h, ':', dateFormat.nn, ' ', dateFormat.am],
      );

  String _getStartTimeString() => _getStartTime().isAtSameMomentAs(dayStartTime)
      ? USE_24_BASED_HOUR ? '0:00' : '0:00 AM'
      : _getGeneralTimeFormatString(_getStartTime());

  String _getEndTimeString() => _getEndTime().isAtSameMomentAs(dayEndTime)
      ? USE_24_BASED_HOUR ? '24:00' : '12:00 AM'
      : _getGeneralTimeFormatString(_getEndTime());

  bool _isAllDayEvent() =>
      (event.allDay ?? false) ||
      _getEndTime().difference(_getStartTime()) == Duration(days: 1);

  Widget _getTime() {
    if (_isAllDayEvent()) {
      return Text(
        'All-day',
        textAlign: TextAlign.center,
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(_getStartTimeString()),
          Text(_getEndTimeString()),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: USE_24_BASED_HOUR ? 48.0 : 69.0,
      child: _getTime(),
    );
  }
}

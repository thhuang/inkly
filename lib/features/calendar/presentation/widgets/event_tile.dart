import 'package:date_format/date_format.dart' as dateFormat;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../domain/entities/event.dart';
import 'event_form/utils/constants.dart';

class EventTile extends StatelessWidget {
  final DateTime _dayStartTime;
  final DateTime _dayEndTime;
  final Event _event;

  EventTile({
    Key key,
    @required dayStartTime,
    @required event,
  })  : assert(event != null),
        assert(dayStartTime != null),
        _event = event,
        _dayStartTime = dayStartTime,
        _dayEndTime = dayStartTime.add(Duration(days: 1)),
        super(key: key);

  DateTime _getStartTime() => _dayStartTime.isAfter(_event.startDateTime)
      ? _dayStartTime
      : _event.startDateTime;

  DateTime _getEndTime() => _dayEndTime.isBefore(_event.endDateTime)
      ? _dayEndTime
      : _event.endDateTime;

  String _getGeneralTimeFormatString(DateTime dateTime) =>
      dateFormat.formatDate(
        dateTime,
        USE_24_BASED_HOUR
            ? [dateFormat.H, ':', dateFormat.nn]
            : [dateFormat.h, ':', dateFormat.nn, ' ', dateFormat.am],
      );

  String _getStartTimeString() =>
      _getStartTime().isAtSameMomentAs(_dayStartTime)
          ? USE_24_BASED_HOUR ? '0:00' : '0:00 AM'
          : _getGeneralTimeFormatString(_getStartTime());

  String _getEndTimeString() => _getEndTime().isAtSameMomentAs(_dayEndTime)
      ? USE_24_BASED_HOUR ? '24:00' : '12:00 AM'
      : _getGeneralTimeFormatString(_getEndTime());

  bool _isAllDayEvent() =>
      (_event.allDay ?? false) ||
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

  Widget _buildTimePanel() {
    return SizedBox(
      width: USE_24_BASED_HOUR ? 48.0 : 69.0,
      child: _getTime(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      title: Row(
        children: <Widget>[
          _buildTimePanel(),
          SizedBox(width: 10.0),
          Container(
            width: 5.0,
            height: 45.0,
            color: Colors.blue,
          ),
          SizedBox(width: 10.0),
          Text(_event.name),
        ],
      ),
      trailing: Icon(FontAwesomeIcons.user),
    );
  }
}

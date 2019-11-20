import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

final _now = DateTime.now();
final _selectedDay = DateTime(_now.year, _now.month, _now.day);
final Map<DateTime, List<String>> _events = {
  _selectedDay.subtract(Duration(days: 30)): [
    'Event A0',
    'Event B0',
    'Event C0',
  ],
  _selectedDay.subtract(Duration(days: 27)): [
    'Event A1',
  ],
  _selectedDay.subtract(Duration(days: 20)): [
    'Event A2',
    'Event B2',
    'Event C2',
    'Event D2',
  ],
  _selectedDay.subtract(Duration(days: 16)): [
    'Event A3',
    'Event B3',
  ],
  _selectedDay.subtract(Duration(days: 10)): [
    'Event A4',
    'Event B4',
    'Event C4',
  ],
  _selectedDay.subtract(Duration(days: 4)): [
    'Event A5',
    'Event B5',
    'Event C5',
  ],
  _selectedDay.subtract(Duration(days: 2)): [
    'Event A6',
    'Event B6',
  ],
  _selectedDay: [
    'Event A7',
    'Event B7',
    'Event C7',
    'Event D7',
  ],
  _selectedDay.add(Duration(days: 1)): [
    'Event A8',
    'Event B8',
    'Event C8',
    'Event D8',
  ],
  _selectedDay.add(Duration(days: 3)): [
    'Event A9',
    'Event A9',
    'Event B9',
  ],
  _selectedDay.add(Duration(days: 7)): [
    'Event A10',
    'Event B10',
    'Event C10',
  ],
  _selectedDay.add(Duration(days: 11)): [
    'Event A11',
    'Event B11',
  ],
  _selectedDay.add(Duration(days: 17)): [
    'Event A12',
    'Event B12',
    'Event C12',
    'Event D12',
  ],
  _selectedDay.add(Duration(days: 22)): [
    'Event A13',
    'Event B13',
  ],
  _selectedDay.add(Duration(days: 26)): [
    'Event A14',
    'Event B14',
    'Event C14',
  ],
};

class Calendar extends StatefulWidget {
  Calendar({Key key}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      events: _events,
      calendarController: _calendarController,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onDaySelected: _onDaySelected,
    );
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onDaySelected(DateTime day, List<dynamic> events) {
    print('CALLBACK: _onDaySelected');
    Provider.of<ValueNotifier<List<String>>>(context).value =
        events.whereType<String>().toList();
  }
}

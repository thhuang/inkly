import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../logicholders/event_list_notifier.dart';

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
      events: Provider.of<EventListNotifier>(context).eventMap,
      calendarController: _calendarController,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onDaySelected: _onDaySelected,
      initialSelectedDay: Provider.of<ValueNotifier<DateTime>>(context).value,
    );
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onDaySelected(DateTime day, List<dynamic> events) {
    print('CALLBACK: _onDaySelected');
    Provider.of<ValueNotifier<DateTime>>(context).value = day;
  }
}

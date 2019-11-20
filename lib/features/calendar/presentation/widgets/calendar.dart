import 'package:flutter/material.dart';
import 'package:inkly/features/calendar/domain/entities/event.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../core/utils/event_list_to_event_map.dart';
import '../logicholders/event_list_notifier.dart';

class Calendar extends StatefulWidget {
  Calendar({Key key}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarController _calendarController;
  DateTime _selectedDay;

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
    final converter = EventListToEventMap();
    return TableCalendar(
      events: converter(Provider.of<EventListNotifier>(context).eventList),
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
    Provider.of<ValueNotifier<List<Event>>>(context).value =
        events.cast<Event>();
  }
}

import 'package:flutter/material.dart';
import 'package:inkly/features/calendar/domain/entities/event.dart';
import 'package:inkly/features/calendar/presentation/logicholders/event_list_notifier.dart';
import 'package:provider/provider.dart';

import '../widgets/calendar.dart';
import '../widgets/event_list.dart';

class CalendarScreen extends StatelessWidget {
  static const String id = 'calendar_screen';

  const CalendarScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider<ValueNotifier<List<Event>>>(
              builder: (_) => ValueNotifier<List<Event>>([]),
            ),
            ChangeNotifierProvider<ValueNotifier<DateTime>>(
              builder: (_) => ValueNotifier<DateTime>(DateTime.now()),
            ),
          ],
          child: Column(
            children: <Widget>[
              Calendar(),
              Divider(height: 3.0),
              Expanded(child: EventList()),
              Expanded(child: TestButton()),
            ],
          ),
        ),
      ),
    );
  }
}

class TestButton extends StatelessWidget {
  const TestButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Container(
        color: Colors.red,
        height: 50.0,
        width: 100.0,
        child: Center(
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
      onPressed: () async {
        final _now = DateTime.now();
        final newEvent = Event(
          name: 'test',
          createDateTime: _now,
          startDateTime: _now.subtract(Duration(days: 1, minutes: 30)),
          endDateTime: _now.subtract(Duration(days: 1)),
        );
        await Provider.of<EventListNotifier>(context).addEvent(newEvent);
      },
    );
  }
}

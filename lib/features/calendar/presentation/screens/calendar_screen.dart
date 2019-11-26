import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/event_list_to_event_map.dart';
import '../../domain/entities/event.dart';
import '../logicholders/event_list_notifier.dart';
import '../widgets/calendar.dart';
import '../widgets/event_list.dart';

class CalendarScreen extends StatelessWidget {
  static const String id = 'calendar_screen';

  const CalendarScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final converter = EventListToEventMap();
    return Scaffold(
      body: SafeArea(
        child: MultiProvider(
          providers: [
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
        final selectedDay =
            Provider.of<ValueNotifier<DateTime>>(context, listen: false).value;
        await Provider.of<EventListNotifier>(context).addEvent(
          Event(
            name: 'test',
            createDateTime: selectedDay,
            startDateTime: selectedDay.subtract(Duration(minutes: 10)),
            endDateTime: selectedDay.add(Duration(minutes: 15)),
          ),
        );
      },
    );
  }
}

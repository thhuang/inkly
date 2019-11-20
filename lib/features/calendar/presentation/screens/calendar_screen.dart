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
        child: ChangeNotifierProvider<ValueNotifier<List<String>>>(
          builder: (_) => ValueNotifier<List<String>>([]),
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
      onPressed: () {
        final event = Event(name: 'test', createDateTime: DateTime.now());
        final state = Provider.of<EventListNotifier>(context).state;
        final eventList = Provider.of<EventListNotifier>(context).eventList;
        print(state);
        print(eventList);
      },
    );
  }
}

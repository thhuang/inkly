import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/event.dart';
import '../logicholders/event_list_notifier.dart';
import '../widgets/calendar.dart';
import '../widgets/event_list.dart';

class CalendarScreen extends StatelessWidget {
  static const String id = 'calendar_screen';

  const CalendarScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ValueNotifier<DateTime>>(
          builder: (_) => ValueNotifier<DateTime>(DateTime.now()),
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Calendar(),
              Divider(height: 3.0),
              Expanded(child: EventList()),
            ],
          ),
        ),
        bottomNavigationBar: CalendarScreenNavigationBar(),
        floatingActionButton: AddEventButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}

class CalendarScreenNavigationBar extends StatelessWidget {
  const CalendarScreenNavigationBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(height: 50.0,)
      ],
    ),
    shape: CircularNotchedRectangle(),
    color: Theme.of(context).scaffoldBackgroundColor,
    );
  }
}

class AddEventButton extends StatelessWidget {
  const AddEventButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        print('XD');
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
      child: Icon(Icons.add),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}

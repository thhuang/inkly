import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/event.dart';
import '../logicholders/event_list_notifier.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
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

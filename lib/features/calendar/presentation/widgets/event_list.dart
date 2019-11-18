import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'event_tile.dart';

class EventList extends StatelessWidget {
  EventList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dayEvents = Provider.of<ValueNotifier<List<String>>>(context).value;

    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: 30.0,
      ),
      itemCount: dayEvents.length,
      itemBuilder: (BuildContext context, int index) {
        return EventTile(
          taskName: dayEvents[index],
        );
      },
    );
  }
}

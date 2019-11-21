import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/event.dart';
import 'event_tile.dart';

class EventList extends StatelessWidget {
  EventList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final day = Provider.of<ValueNotifier<DateTime>>(context).value;
    final dayEvents =
        Provider.of<ValueNotifier<Map<DateTime, List<Event>>>>(context)
                .value[DateTime(day.year, day.month, day.day)] ??
            [];

    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: 30.0,
      ),
      itemCount: dayEvents.length,
      itemBuilder: (BuildContext context, int index) {
        return EventTile(
          event: dayEvents[index],
        );
      },
    );
  }
}

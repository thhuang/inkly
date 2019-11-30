import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/event_comparator.dart';
import '../logicholders/event_list_notifier.dart';
import 'event_tile.dart';

class EventList extends StatelessWidget {
  EventList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<ValueNotifier<DateTime>, EventListNotifier>(
      builder: (context, date, events, child) {
        final day = DateTime(date.value.year, date.value.month, date.value.day);
        final dayEvents = events.eventMap[day] ?? [];
        dayEvents.sort(EventComparator());
        return ListView.builder(
          padding: EdgeInsets.only(
            right: 20.0,
            left: 20.0,
            bottom: 30.0,
          ),
          itemCount: dayEvents.length,
          itemBuilder: (context, index) => EventTile(
            dayStartTime: day,
            event: dayEvents[index],
          ),
        );
      },
    );
  }
}

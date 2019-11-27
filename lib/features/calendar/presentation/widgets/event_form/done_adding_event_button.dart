import 'package:flutter/material.dart';
import 'package:inkly/features/calendar/domain/entities/event.dart';
import 'package:inkly/features/calendar/presentation/logicholders/event_list_notifier.dart';
import 'package:provider/provider.dart';

import 'top_corner_icon_button.dart';

class DoneAddingEventButton extends StatelessWidget {
  const DoneAddingEventButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<EventListNotifier, ValueNotifier<DateTime>>(
      builder: (context, events, day, child) => TopCornerIconButton(
        icon: Icons.done,
        onPressed: () async {
          await events.addEvent(
            Event(
              name: 'test',
              createDateTime: DateTime.now(),
              startDateTime: day.value.subtract(Duration(minutes: 10)),
              endDateTime: day.value.add(Duration(minutes: 15)),
            ),
          );
          Navigator.pop(context);
        },
      ),
    );
  }
}

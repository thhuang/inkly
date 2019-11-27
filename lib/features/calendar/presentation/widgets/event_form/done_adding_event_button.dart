import 'package:flutter/material.dart';
import 'package:inkly/features/calendar/domain/entities/event.dart';
import 'package:inkly/features/calendar/presentation/logicholders/event_list_notifier.dart';
import 'package:provider/provider.dart';

import 'top_corner_icon_button.dart';

class DoneAddingEventButton extends StatelessWidget {
  const DoneAddingEventButton({
    Key key,
  }) : super(key: key);

  bool _validateInput(Event event) {
    return event.name != '';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<EventListNotifier, ValueNotifier<DateTime>,
        ValueNotifier<Event>>(
      builder: (context, events, day, newEvent, child) => TopCornerIconButton(
        icon: Icons.done,
        color: _validateInput(newEvent.value) ? null : Colors.black26,
        onPressed: () async {
          if (_validateInput(newEvent.value)) {
            await events.addEvent(newEvent.value);
            FocusScope.of(context).unfocus();
            await Future.delayed(Duration(milliseconds: 100));
            Navigator.pop(context);
          } else {
            // TODO: should notify the user
            print('Invalid input!');
          }
        },
      ),
    );
  }
}

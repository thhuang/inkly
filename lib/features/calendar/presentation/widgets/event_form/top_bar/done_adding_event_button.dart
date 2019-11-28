import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/entities/event.dart';
import '../../../logicholders/event_list_notifier.dart';
import '../../../logicholders/event_notifier.dart';
import '../top_corner_icon_button.dart';
import '../utils/pop_event_form.dart';

class DoneAddingEventButton extends StatelessWidget {
  const DoneAddingEventButton({
    Key key,
  }) : super(key: key);

  bool _validateInput(Event event) {
    return event.name != '';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<EventListNotifier, ValueNotifier<DateTime>, EventNotifier>(
      builder: (context, events, day, newEvent, child) => TopCornerIconButton(
        icon: Icons.done,
        color: _validateInput(newEvent.event) ? null : Colors.black26,
        onPressed: () async {
          if (_validateInput(newEvent.event)) {
            await events.addEvent(newEvent.event);
            await popEventForm(context);
          } else {
            // TODO: should notify the user
            print('Invalid input!');
          }
        },
      ),
    );
  }
}

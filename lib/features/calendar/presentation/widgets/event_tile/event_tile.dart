import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inkly/features/calendar/presentation/logicholders/event_list_notifier.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/event.dart';
import 'time_displayer.dart';

class EventTile extends StatelessWidget {
  final DateTime _dayStartTime;
  final DateTime _dayEndTime;
  final Event _event;

  EventTile({
    Key key,
    @required dayStartTime,
    @required event,
  })  : assert(event != null),
        assert(dayStartTime != null),
        _event = event,
        _dayStartTime = dayStartTime,
        _dayEndTime = dayStartTime.add(Duration(days: 1)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: () async {
        await Provider.of<EventListNotifier>(context).deleteEvent(_event);
      },
      contentPadding: EdgeInsets.all(0),
      title: Padding(
        padding: EdgeInsets.only(left: 20.0),
        child: Row(
          children: <Widget>[
            TimeDisplayer(
              event: _event,
              dayStartTime: _dayStartTime,
              dayEndTime: _dayEndTime,
            ),
            SizedBox(width: 10.0),
            Container(
              width: 5.0,
              height: 45.0,
              color: Colors.blue,
            ),
            SizedBox(width: 10.0),
            Text(_event.name),
          ],
        ),
      ),
      trailing: Padding(
        padding: EdgeInsets.only(right: 20.0),
        child: Icon(FontAwesomeIcons.user),
      ),
    );
  }
}

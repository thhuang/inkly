import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../domain/entities/event.dart';

class EventTile extends StatelessWidget {
  final Event event;

  const EventTile({
    Key key,
    @required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      title: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Text('${event.startDateTime.hour}:${event.startDateTime.minute}'),
              Text('${event.endDateTime.hour}:${event.endDateTime.minute}'),
            ],
          ),
          SizedBox(width: 10.0),
          Container(
            width: 5.0,
            height: 45.0,
            color: Colors.blue,
          ),
          SizedBox(width: 10.0),
          Text(event.name),
        ],
      ),
      trailing: Icon(FontAwesomeIcons.user),
    );
  }
}

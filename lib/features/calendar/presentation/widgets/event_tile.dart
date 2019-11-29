import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../domain/entities/event.dart';
import 'package:date_format/date_format.dart' as dateFormat;

class EventTile extends StatelessWidget {
  final Event event;

  const EventTile({
    Key key,
    @required this.event,
  }) : super(key: key);

  Widget _getTime() {
    if (event.allDay ?? false) {
      return Text('All-day', textAlign: TextAlign.center,);
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(dateFormat.formatDate(
            event.startDateTime,
            [dateFormat.h, ':', dateFormat.nn, ' ', dateFormat.am],
          )),
          Text(dateFormat.formatDate(
            event.endDateTime,
            [dateFormat.h, ':', dateFormat.nn, ' ', dateFormat.am],
          )),
        ],
      );
    }
  }

  Widget _buildTimePanel() {
    return SizedBox(
      width: 64.0,
      child: _getTime(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      title: Row(
        children: <Widget>[
          _buildTimePanel(),
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

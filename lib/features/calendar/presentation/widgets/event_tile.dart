import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EventTile extends StatelessWidget {
  final String taskName;

  const EventTile({
    Key key,
    @required this.taskName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      title: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Text('1:30 PM'),
              Text('3:30 PM'),
            ],
          ),
          SizedBox(width: 10.0),
          Container(
            width: 5.0,
            height: 45.0,
            color: Colors.blue,
          ),
          SizedBox(width: 10.0),
          Text(taskName),
        ],
      ),
      trailing: Icon(FontAwesomeIcons.user),
    );
  }
}

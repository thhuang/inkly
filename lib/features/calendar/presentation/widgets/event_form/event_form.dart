import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/event.dart';
import '../../logicholders/event_list_notifier.dart';
import 'top_corner_icon_button.dart';

class EventForm extends StatelessWidget {
  const EventForm({
    Key key,
  }) : super(key: key);

  TextStyle _getTitleTextStyle() => TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.2,
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: 10.0),
            TopCornerIconButton(icon: Icons.clear),
            Expanded(child: Container()),
            TopCornerIconButton(icon: Icons.done),
            SizedBox(width: 10.0),
          ],
        ),
        TextField(
          onChanged: (value) => null,
          autofocus: true,
          textAlign: TextAlign.center,
          cursorColor: Theme.of(context).primaryColor,
          style: _getTitleTextStyle(),
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(),
            ),
            hintText: 'Title',
            hintStyle: _getTitleTextStyle(),
          ),
        ),
        SizedBox(height: 30.0),
        TestButton(),
      ],
    );
  }
}

class TestButton extends StatelessWidget {
  const TestButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<EventListNotifier, ValueNotifier<DateTime>>(
      builder: (context, events, day, child) => FlatButton(
        child: Center(
          child: Container(
            color: Colors.red,
            height: 50.0,
            width: 100.0,
            child: Center(
              child: Icon(Icons.add, color: Colors.white),
            ),
          ),
        ),
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

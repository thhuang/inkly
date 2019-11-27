import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/event.dart';
import '../../logicholders/event_list_notifier.dart';
import 'clear_adding_event_button.dart';
import 'done_adding_event_button.dart';

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
    return ChangeNotifierProvider<ValueNotifier<Event>>(
      builder: (_) => ValueNotifier<Event>(
        Event(
          createDateTime: DateTime.now(),
          name: '',
        ),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: 10.0),
              ClearAddingEventButton(),
              Expanded(child: Container()),
              DoneAddingEventButton(),
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
        ],
      ),
    );
  }
}

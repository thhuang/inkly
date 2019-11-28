import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../logicholders/event_notifier.dart';

class TitleField extends StatelessWidget {
  const TitleField({Key key}) : super(key: key);

  TextStyle _getTitleTextStyle() => TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.2,
      );

  @override
  Widget build(BuildContext context) {
    return Consumer<EventNotifier>(
      builder: (context, event, child) => TextField(
        onChanged: (title) {
          event.updateEventFields(
            name: title,
            createDateTime: DateTime.now(),
          );
        },
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
    );
  }
}

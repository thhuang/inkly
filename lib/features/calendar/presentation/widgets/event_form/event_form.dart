import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/event.dart';
import '../../logicholders/event_notifier.dart';
import 'date_time_field/date_time_field.dart';
import 'title_field.dart';
import 'top_bar/top_bar.dart';

class EventForm extends StatelessWidget {
  const EventForm({
    Key key,
  }) : super(key: key);

  Event _buildDefaultEvent(BuildContext context) {
    final currentDateTime = DateTime.now();
    final selectedDate = Provider.of<ValueNotifier<DateTime>>(context).value;
    final defaultStartDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      currentDateTime.hour,
      currentDateTime.minute,
      currentDateTime.second,
    );
    final defaultEndDateTime = defaultStartDateTime.add(Duration(hours: 1));

    return Event(
      createDateTime: currentDateTime,
      name: '',
      startDateTime: defaultStartDateTime,
      endDateTime: defaultEndDateTime,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EventNotifier>(
      builder: (_) => EventNotifier(_buildDefaultEvent(context)),
      child: Column(
        children: <Widget>[
          TopBar(),
          TitleField(),
          SizedBox(height: 10.0),
          DateTimeField(),
        ],
      ),
    );
  }
}

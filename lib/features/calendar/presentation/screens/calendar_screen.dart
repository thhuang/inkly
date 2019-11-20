import 'package:flutter/material.dart';
import 'package:inkly/features/calendar/calendar_provider_setup.dart';
import 'package:provider/provider.dart';

import '../widgets/calendar.dart';
import '../widgets/event_list.dart';

class CalendarScreen extends StatelessWidget {
  static const String id = 'calendar_screen';

  const CalendarScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: calendarProviders,
      child: Scaffold(
        body: SafeArea(
          child: ChangeNotifierProvider<ValueNotifier<List<String>>>(
            builder: (_) => ValueNotifier<List<String>>([]),
            child: Column(
              children: <Widget>[
                Calendar(),
                Divider(height: 3.0),
                Expanded(
                  child: EventList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

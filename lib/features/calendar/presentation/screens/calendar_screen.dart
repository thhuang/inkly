import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/calendar.dart';
import '../widgets/custom_bottom_navigation_bar.dart';
import '../widgets/custom_floating_action_button.dart';
import '../widgets/event_list.dart';

class CalendarScreen extends StatelessWidget {
  static const String id = 'calendar_screen';

  const CalendarScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ValueNotifier<DateTime>>(
          builder: (_) => ValueNotifier<DateTime>(DateTime.now()),
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Calendar(),
              Divider(height: 3.0),
              Expanded(child: EventList()),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(),
        floatingActionButton: CustomFloatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}

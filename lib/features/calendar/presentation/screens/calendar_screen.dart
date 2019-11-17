import 'package:flutter/material.dart';
import 'package:inkly/features/calendar/presentation/widgets/task_list.dart';

import '../widgets/calendar.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Calendar(),
            Expanded(
              child: TaskList(),
            ),
          ],
        ),
      ),
    );
  }
}

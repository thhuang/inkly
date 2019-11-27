import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/presentation/custom_widgets/custom_bottom_navigation_bar.dart';
import '../widgets/add_event_floating_action_button.dart';
import '../widgets/calendar.dart';
import '../widgets/event_list.dart';

class CalendarScreen extends StatelessWidget {
  static const String id = 'calendar_screen';

  const CalendarScreen({Key key}) : super(key: key);

  List<Widget> _buildNevigationBarItems() => null;

  List<Widget> _buildScreenMainColumnItems() => <Widget>[
        Calendar(),
        Divider(height: 3.0),
        Expanded(child: EventList()),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: _buildScreenMainColumnItems(),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        children: _buildNevigationBarItems(),
        color: Theme.of(context).primaryColor,
      ),
      floatingActionButton: AddEventFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

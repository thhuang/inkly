import 'package:flutter/material.dart';

import 'features/calendar/presentation/screens/calendar_screen.dart';
import 'features/sign_in_service/presentation/screens/sign_in_screen.dart';

class InklyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inkly App',
      theme: Theme.of(context).copyWith(
        backgroundColor: Colors.white,
      ),
      initialRoute: SignInScreen.id,
      routes: {
        SignInScreen.id: (context) => SignInScreen(),
        CalendarScreen.id: (context) => CalendarScreen(),
      },
    );
  }
}

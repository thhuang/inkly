import 'package:flutter/material.dart';
import 'package:inkly/features/calendar/presentation/screens/calendar_screen.dart';
import 'package:inkly/features/landing/presentation/screens/landing_screen.dart';
import 'package:inkly/features/login_service/presentation/screens/login_screen.dart';

class InklyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inkly App',
      theme: Theme.of(context).copyWith(
        backgroundColor: Colors.white,
      ),
      initialRoute: LandingScreen.id,
      routes: {
        LandingScreen.id: (context) => LandingScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        CalendarScreen.id: (context) => CalendarScreen(),
      },
    );
  }
}

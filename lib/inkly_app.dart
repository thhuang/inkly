import 'package:flutter/material.dart';
import 'package:inkly/features/landing/presentation/screens/landing_screen.dart';
import 'package:inkly/provider_setup.dart';
import 'package:provider/provider.dart';

import 'features/calendar/presentation/screens/calendar_screen.dart';

class InklyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'Inkly App',
        theme: Theme.of(context).copyWith(
          backgroundColor: Colors.white,
        ),
        initialRoute: LandingScreen.id,
        routes: {
          LandingScreen.id: (context) => LandingScreen(),
          CalendarScreen.id: (context) => CalendarScreen(),
        },
      ),
    );
  }
}

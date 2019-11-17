import 'package:flutter/material.dart';
import 'package:inkly/features/calendar/presentation/screens/calendar_screen.dart';

class InklyApp extends StatelessWidget {
  final int primaryColorCode = 0xFF58B2DC; // SORA
  final int scaffoldBackgroundColor = 0xFF0F2540; // KON

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inkly App',
      home: CalendarScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:inkly/features/sign_in_service/presentation/screens/sign_in_screen.dart';

class LandingScreen extends StatelessWidget {
  static const String id = 'landing_screen';
  const LandingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SignInScreen();
  }
}

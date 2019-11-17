import 'package:flutter/material.dart';
import 'package:inkly/features/landing/presentation/widgets/sign_in_buttons.dart';

import '../widgets/logo.dart';

class LandingScreen extends StatelessWidget {
  static const String id = 'landing_screen';
  const LandingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Logo(size: 60.0),
            SizedBox(height: 50.0),
            SignInButtons(),
            SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }
}

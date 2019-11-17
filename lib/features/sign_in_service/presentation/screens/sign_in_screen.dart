import 'package:flutter/material.dart';

import '../widgets/logo.dart';
import '../widgets/sign_in_buttons.dart';

class SignInScreen extends StatelessWidget {
  static const String id = 'sign_in_screen';
  const SignInScreen({Key key}) : super(key: key);

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

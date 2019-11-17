import 'package:flutter/material.dart';

import '../../../calendar/presentation/screens/calendar_screen.dart';
import '../../constants.dart';
import 'buttons.dart/image_button.dart';
import 'buttons.dart/rounded_outline_button.dart';
import 'dividers/custom_divider.dart';

class SignInButtons extends StatelessWidget {
  const SignInButtons({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 5.0),
        Container(
          width: 150.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ImageButton(
                padding: EdgeInsets.all(8.0),
                assetName: 'images/oauth_icons/2x/facebook-logo.png',
                color: kFacebookColor,
                onPressed: () {
                  // TODO: sign in with firebase authentication
                  print('Sign in with Facebook');
                },
              ),
              ImageButton(
                padding: EdgeInsets.all(8.0),
                assetName: 'images/oauth_icons/2x/google-logo.png',
                onPressed: () {
                  // TODO: sign in with firebase authentication
                  print('Sign in with Google');
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 5.0),
        CustomDivider(
          child: Text('or'),
        ),
        SizedBox(height: 7.0),
        RoundedOutlineButton(
          color: Colors.black26,
          child: Text(
            'Sign in anonymously',
            style: TextStyle(color: Colors.black54),
          ),
          onPressed: () {
            // TODO: sign in with firebase authentication
            print('Sign in anonymously');
            Navigator.pushNamed(context, CalendarScreen.id);
          },
        ),
      ],
    );
  }
}

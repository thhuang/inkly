import 'package:flutter/material.dart';

Future<void> popEventForm(BuildContext context) async {
  FocusScope.of(context).unfocus();
  await Future.delayed(Duration(milliseconds: 200));
  Navigator.pop(context);
}

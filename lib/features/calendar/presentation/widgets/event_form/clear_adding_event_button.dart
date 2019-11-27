import 'package:flutter/material.dart';

import 'top_corner_icon_button.dart';

class ClearAddingEventButton extends StatelessWidget {
  const ClearAddingEventButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TopCornerIconButton(
      icon: Icons.clear,
      onPressed: () async {
        FocusScope.of(context).unfocus();
        await Future.delayed(Duration(milliseconds: 100));
        Navigator.pop(context);
      },
    );
  }
}

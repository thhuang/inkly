import 'package:flutter/material.dart';

import 'top_corner_icon_button.dart';
import 'utils/pop_event_form.dart';

class ClearAddingEventButton extends StatelessWidget {
  const ClearAddingEventButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TopCornerIconButton(
      icon: Icons.clear,
      onPressed: () async {
        await popEventForm(context);
      },
    );
  }
}

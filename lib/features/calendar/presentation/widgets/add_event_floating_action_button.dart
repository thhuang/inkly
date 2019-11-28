import 'package:flutter/material.dart';

import '../../../../core/presentation/custom_widgets/round_modal_bottom_sheet.dart';
import 'event_form/event_form.dart';

class AddEventFloatingActionButton extends StatelessWidget {
  const AddEventFloatingActionButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        showRoundModalBottomSheet(
          context: context,
          padding: EdgeInsets.only(top: 30.0),
          child: EventForm(),
        );
      },
      child: Icon(Icons.add),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}

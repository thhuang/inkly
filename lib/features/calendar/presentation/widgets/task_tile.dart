import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final String taskName;

  const TaskTile({
    Key key,
    @required this.taskName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      title: Text(taskName),
    );
  }
}

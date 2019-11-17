import 'package:flutter/material.dart';

import 'task_tile.dart';

class TaskList extends StatelessWidget {
  TaskList({Key key}) : super(key: key);
  List<String> tasks = [
    'Buy milk',
    'Prepare launch',
    'Walk the dog',
    'Read papers',
    'Study Flutter',
    'Wash dishes',
    'Add some more tasks',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding:
          EdgeInsets.symmetric(horizontal: 30.0),
      itemCount: tasks.length,
      itemBuilder: (BuildContext context, int index) {
        return TaskTile(
          taskName: tasks[index],
        );
      },
    );
  }
}

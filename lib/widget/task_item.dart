import 'package:flutter/material.dart';

import '../Model/task.dart';

class TaskTile extends StatelessWidget{
  final Task task;
  const TaskTile({super.key, required this.task});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
         leading: Text(
           task.name
         ),
          trailing: IconButton(onPressed: () {  }, icon:Icon(Icons.edit) ,

          ),
        ),
        Divider(height: 3,)
      ],
    );
  }
}
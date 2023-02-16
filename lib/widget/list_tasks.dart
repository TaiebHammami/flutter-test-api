import 'package:flutter/material.dart';
import 'package:flutter_api/Model/task.dart';
import 'package:flutter_api/widget/task_item.dart';

class ListOfTasks extends StatelessWidget{
  final List<Task> tasks ;

  const ListOfTasks({super.key, required this.tasks});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
        itemBuilder: (context,i){
        return TaskTile(task:tasks[i]);
        });
  }
}

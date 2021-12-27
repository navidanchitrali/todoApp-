import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final bool? isChecked;
  final String? taskTitle;
  final String? taskTime;
  final Function callBack;

  TaskTile(
      {Key? key,
      this.taskTitle,
      this.taskTime,
      this.isChecked,
      required this.callBack});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
          activeColor: Colors.blue,
          value: isChecked!,
          onChanged: (newValue) {
            callBack(newValue);
          }),
      title: Text(taskTitle!),
      trailing: Text(taskTime!),
    );
  }
}

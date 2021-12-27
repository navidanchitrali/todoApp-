import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mytodoapp/ui/screens/HomePage/home_screen.dart';
import 'package:mytodoapp/ui/screens/add%20task/add_task_view_model.dart';
import 'package:provider/provider.dart';

class AddTask extends StatelessWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddTaskViewModel>(builder: (context, model, child) {
      return Scaffold(
          backgroundColor: Colors.grey,
          body: Padding(
            padding: EdgeInsets.only(top: 100, left: 20, right: 20),
            child: Column(
              children: [
                TextFormField(
                    controller: model.addTaskTextEditingController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'task name'),
                    onChanged: (value) {}),
                SizedBox(
                  height: 20.h,
                ),
                ElevatedButton(
                    onPressed: () async {
                      await model.addTask();
                      model.addTaskTextEditingController.text = '';
                      Get.to(HomeScreen());
                    },
                    child: const Text('Add Task'))
              ],
            ),
          ));
    });
  }
}

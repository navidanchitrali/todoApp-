import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mytodoapp/core/services/auth_services.dart';
import 'package:mytodoapp/ui/custom_widgets/task/task_tile.dart';
import 'package:mytodoapp/ui/screens/add%20task/add_task_screen.dart';
import 'package:mytodoapp/ui/screens/add%20task/add_task_view_model.dart';
import 'package:mytodoapp/ui/screens/authentication/login/login_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AddTaskViewModel>(builder: (context, model, child) {
      return Scaffold(
        backgroundColor: Colors.grey,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: const Icon(Icons.add, color: Colors.grey),
          onPressed: () {
            Get.to(() => const AddTask());
          },
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 50, left: 25),
                child: GestureDetector(
                  onTap: () {
                    AuthService().logout();
                    Get.offAll(LoginScreen());
                    Get.to(LoginScreen());
                  },
                  child: const Text('LogOut',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                )),
            const Center(
                child: Text(
              'My Task',
              style: TextStyle(color: Colors.white, fontSize: 25),
            )),
            SizedBox(
              height: 10.h,
            ),
            Center(
              child: Text(model.allTask.length.toString() + ' tasks',
                  style: TextStyle(color: Colors.white, fontSize: 15)),
            ),
            Expanded(
              child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  itemBuilder: (context, index) => InkWell(
                          child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                        child: TaskTile(
                          taskTitle: model.allTask[index].taskTitle,
                          taskTime: model.allTask[index].taskTime,
                          isChecked: model.allTask[index].isDone,
                          callBack: (newValue) {
                            setState(() {
                              model.allTask[index].isDone = newValue;
                            });
                            Future.delayed(const Duration(seconds: 1), () {
                              // Here you can write your code
                              model.removeTask(model.allTask[index],
                                  model.allTask[index].docId!);
                            });
                          },
                        ),
                      )),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 20.h,
                      ),
                  itemCount: model.allTask.length),
            ),
          ],
        ),
      );
    });
  }
}

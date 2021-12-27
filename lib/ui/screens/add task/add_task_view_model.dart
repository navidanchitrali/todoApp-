import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mytodoapp/core/enums/view_state.dart';
import 'package:mytodoapp/core/models/add_task.dart';
import 'package:mytodoapp/core/models/app_user.dart';
import 'package:mytodoapp/core/models/custom_auth_result.dart';
import 'package:mytodoapp/core/services/auth_services.dart';
import 'package:mytodoapp/core/services/database_services.dart';
import 'package:mytodoapp/core/view_model/base_view_model.dart';
import 'package:mytodoapp/ui/locator.dart';
import 'package:intl/intl.dart';

class AddTaskViewModel extends BaseViewModel {
  AppUser appUser = AppUser();
  final _authService = locator<AuthService>();
  final _dbService = DatabaseService();
  late CustomAuthResult authResult;

  FirebaseAuth auth = FirebaseAuth.instance;
  List<Task> allTask = [];

  TextEditingController addTaskTextEditingController = TextEditingController();

  AddTaskViewModel() {
    init();
  }

  init() async {
    setState(ViewState.loading);

    await getTask();

    setState(ViewState.idle);
  }

  addTask() async {
    setState(ViewState.busy);

    Task task = new Task();
    task.taskTitle = addTaskTextEditingController.text;
    DateTime now = DateTime.now();
    String formattedTime = DateFormat.Hm().format(now);
    task.taskTime = formattedTime;
    task.id = authResult.user!.uid;

    try {
      allTask.add(task);
      await _dbService.addTask(task);
    } catch (e, s) {
      debugPrint("Task View Model addTask() EXCEPTION $e");
      print(s);
    }

    setState(ViewState.idle);
  }

  getTask() async {
    setState(ViewState.busy);

    try {
      allTask = await _dbService.getCurrentUserTask();
      print(allTask.length);
    } catch (e, s) {
      debugPrint("Task View Model getTask() EXCEPTION $e");
      print(s);
    }

    setState(ViewState.idle);
  }

  removeTask(Task task, String docId) async {
    setState(ViewState.busy);

    try {
      await _dbService.removeTask(task, docId);
      allTask.remove(task);
    } catch (e, s) {
      debugPrint("Task View Model removeTask() EXCEPTION $e");
      print(s);
    }

    setState(ViewState.idle);
  }
}

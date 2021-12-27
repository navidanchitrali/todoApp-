// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:mytodoapp/core/models/add_task.dart';
import 'package:mytodoapp/core/models/app_user.dart';

class DatabaseService {
  final _db = FirebaseFirestore.instance;
  static final DatabaseService _singleton = DatabaseService._internal();

  FirebaseAuth auth = FirebaseAuth.instance;

  factory DatabaseService() {
    return _singleton;
  }

  DatabaseService._internal();

  ///
  /// Register User
  ///
  registerUser(AppUser user) async {
    print(user.id.toString() + "ID is ssss-------");
    try {
      await _db.collection('reg_user').doc(user.id).set(user.toJson());
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/registerUser $e');
      // ignore: avoid_print
      print(s);
    }
  }

  ///
  /// Get User
  ///
  Future<AppUser?> getUser(id) async {
    print('@getUser: id: $id');
    try {
      final snapshot = await _db.collection('reg_user').doc(id).get();
      debugPrint('User Data: ${snapshot.data()}');
      return AppUser.fromJson(
          snapshot.data() as Map<String, dynamic>, snapshot.id);
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/getUser $e');
      print(s);
      return null;
    }
  }

  ///
  /// Add Task to Firestore Database
  ///

  addTask(Task task) async {
    final firebaseDbRef = FirebaseFirestore.instance.collection('Tasks').doc();
    task.docId = firebaseDbRef.id;

    await firebaseDbRef.set(task.toJson());
  }

  ///
  /// Get all task of current user
  ///
  Future<List<Task>> getCurrentUserTask() async {
    List<Task> allTask = [];
    try {
      final snapshot = await _db
          .collection('Tasks')
          .where("id", isEqualTo: auth.currentUser!.uid)
          .get();

      if (snapshot.docs.isNotEmpty) {
        for (final user in snapshot.docs) {
          allTask.add(Task.fromJson(user.data(), user.id));
        }
      }
    } catch (e, s) {
      debugPrint("DataBaseServices  getCurrentUserTask() Exception: $e}");
      print(s);
    }
    return allTask;
  }

  removeTask(Task task, String docId) async {
    try {
      _db.collection('Tasks').doc(docId).delete();
    } catch (e, s) {
      debugPrint("DataBaseServices  removeTask() Exception: $e}");
      print(s);
    }
  }
}

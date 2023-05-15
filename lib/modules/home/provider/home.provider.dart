import 'package:flutter/material.dart';
import 'package:todoapp/modules/task/view/add_task.view.dart';
import 'package:todoapp/shared/models/task.model.dart';
import 'package:todoapp/services/firestore/firestore.service.dart';

import '../../../shared/widgets/task_dialog.widget.dart';

class HomeProvider extends ChangeNotifier {
  final firestoreService = FirestoreService();

  List<TaskModel>? tasks;

  void showTaskDialog(BuildContext context, TaskModel task) async {
    await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return TaskDialog(task: task);
        });
  }

  void addTask(TaskModel t) {
    tasks?.add(t);
    notifyListeners();
  }

  void removeTask(TaskModel t) async {
    await firestoreService.removeTask(t);
    tasks?.remove(t);
    notifyListeners();
  }

  void updateTask(TaskModel t, int index) {
    tasks?[index] = t;
    notifyListeners();
  }

  void editTask(BuildContext context, TaskModel t) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddTaskView(task: t)));
  }

  Future<void> getTasks() async {
    tasks = await firestoreService.getTasks();
    notifyListeners();
  }
}

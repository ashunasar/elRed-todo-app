import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoapp/shared/models/task.model.dart';
import 'package:todoapp/core/utils/app_logger.dart';
import 'package:todoapp/core/utils/util_functions.dart';

class FirestoreService {
  final collectionRef = FirebaseFirestore.instance.collection('tasks');
  Future<List<TaskModel>> getTasks() async {
    try {
      List<TaskModel> tasks = [];

      QuerySnapshot snapshots = await collectionRef.get();
      for (QueryDocumentSnapshot doc in snapshots.docs.where((element) =>
          (element.data() as Map<String, dynamic>)['uId'] ==
          FirebaseAuth.instance.currentUser!.uid)) {
        TaskModel task = TaskModel.fromJson(doc.data() as Map<String, dynamic>);
        task.id = doc.id;
        tasks.add(task);
      }
      return tasks;
    } on FirebaseException catch (e) {
      UtilFunctions.showToast(message: 'Something went wrong');
      AppLogger.printLog(e.message);
      return [];
    }
  }

  Future<void> addTask(TaskModel task) async {
    try {
      await collectionRef.add(task.toJson());
      UtilFunctions.showToast(message: 'Your task is created! 🎉');
    } on FirebaseException catch (e) {
      UtilFunctions.showToast(message: 'Something went wrong');
      AppLogger.printLog(e.message);
    }
  }

  Future<void> removeTask(TaskModel task) async {
    try {
      await collectionRef.doc(task.id).delete();
      UtilFunctions.showToast(message: 'Your task is deleted!');
    } on FirebaseException catch (e) {
      UtilFunctions.showToast(message: 'Something went wrong');
      AppLogger.printLog(e.message);
    }
  }

  Future<void> updateTask(TaskModel task) async {
    try {
      await collectionRef.doc(task.id).update(task.toJson());
      UtilFunctions.showToast(message: 'Your task is updated! 🎉');
    } on FirebaseException catch (e) {
      UtilFunctions.showToast(message: 'Something went wrong');
      AppLogger.printLog(e.message);
    }
  }
}

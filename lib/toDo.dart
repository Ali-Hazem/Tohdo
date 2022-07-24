import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ToDo {
  ToDo(this.task, this.subTask, this.createdTime, this.isChecked);
  String task;
  String? subTask;
  DateTime? createdTime;
  bool isChecked; //whether the task is done or finished

}
final String uid = FirebaseAuth.instance.currentUser!.uid;
final CollectionReference todo =
    FirebaseFirestore.instance.collection('users').doc(uid).collection('todos');

final newToDo = ToDo('', null, DateTime.now(), false);

void addtodo() {
  todo.add({
    'task': newToDo.task,
    'subTask': newToDo.subTask,
    'createdTime': newToDo.createdTime,
    'isChecked': newToDo.isChecked,
  });
}

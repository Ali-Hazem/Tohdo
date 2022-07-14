// ignore_for_file: invalid_required_positional_param, file_names, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:first_project/todoSection/Home.dart';

class ToDo {
  ToDo(this.task, this.subTask, this.createdTime, this.isChecked);
  String task;
  String? subTask;
  DateTime? createdTime;
  bool isChecked; //whether the task is done or finished

}
final String uid = FirebaseAuth.instance.currentUser!.uid;
final CollectionReference todo = FirebaseFirestore.instance
    .collection('users')
    .doc(uid)
    .collection('todos');

final newToDo = ToDo('', null, null, false);

void removetodo() => todo.doc('task').delete();

void addtodo() {
  todo.add({
    'task': newToDo.task,
    'subTask': newToDo.subTask,
    'createdTime': newToDo.createdTime,
    'isChecked': newToDo.isChecked,
  });
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ToDo {
  ToDo(this.task, this.subTask, this.date, this.isChecked);
  String task;
  String? subTask;
  String date;
  bool isChecked; //whether the task is done or finished

}

String? uid = FirebaseAuth.instance.currentUser?.uid.toString();
final todo =
    FirebaseFirestore.instance.collection('users').doc(uid).collection('todos');

final newToDo = ToDo('', '', '', false);

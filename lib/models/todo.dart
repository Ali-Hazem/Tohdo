import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_project/models/views.dart';
import 'package:first_project/todoSection/models/tabs.dart';
import 'todoCardTitle.dart';
import 'package:first_project/todoSection/Home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Todo with ChangeNotifier {
  Todo({this.todo, this.subTask, this.date, this.isChecked, this.id});
  String? todo;
  String? subTask;
  String? date;
  bool? isChecked;
  String? id;

  void Function()? deleteTodoCollection(todoDate) {
    //delete from firebase
    todosRef.get().then((snapshot) {
      for (DocumentSnapshot doc in snapshot.docs) {
        doc.reference.delete();
      }
    });
    //delete from the todoDate map
    for (var key in todoDate.keys.toList()) {
      todoDate.remove(key);
      print(todoDate);
    }

    _views.clear();
    _tabs.clear();
    print(_tabs);
    print(_views);

    notifyListeners();
    return null;
  }
}

Future<void> firstLoadTabs(BuildContext context) async {
  try {
    await firstLoadFirebase(context: context);
    DocumentSnapshot<Map<String, dynamic>> todayDoc =
        await todosRef.doc(newTodo.id).get();
    context.read<Tabs>().addTabs(todayDoc['date']);
    Tabs().addTabs(todayDoc['date']);
    context.read<Views>().addView(Container());
    Views().addView(Container());
  } on FirebaseFirestore catch (e) {
    throw Exception();
  }
}

final Todo newTodo = Todo(
  todo: '',
  subTask: '',
  date: '',
  isChecked: false,
  id: '',
);

String uid = FirebaseAuth.instance.currentUser!.uid.toString();
final todosRef =
    FirebaseFirestore.instance.collection('users').doc(uid).collection('todos');

final _views = Views().views;
final _tabs = Tabs().tabs;
final _todos = TodoCardTitle().todos;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_project/todoSection/models/views.dart';
import 'package:first_project/todoSection/models/tabs.dart';
import 'todoCardTitle.dart';
import 'package:first_project/todoSection/Home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ToDo with ChangeNotifier {
  ToDo({this.task, this.subTask, this.date, this.isChecked, this.id});
  String? task;
  String? subTask;
  String? date;
  bool? isChecked;
  String? id;

// void getDate(BuildContext context) {
//   todo.get().then((QuerySnapshot snapshot) => snapshot.docs.forEach((dateDoc) {
//         _tabs.add(dateDoc['date']);
//         print(_tabs);
//         context.read<Tabs>().addTabs(dateDoc['date']);
//         print(Tabs().tabs);
//       }));
//       notifyListeners();
// }

  void Function()? deleteTodoCollection(todoDate) {
    //delete from firebase
    todo.get().then((snapshot) {
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
Future<void> getDate(BuildContext context) async {
      try {
        await firstLoadFirebase(context: context);
        DocumentSnapshot<Map<String, dynamic>> todayDoc = await todo.doc(newToDo.id).get();
        context.read<Tabs>().addTabs(todayDoc['date']);
        context.read<Views>().addView(Container());

      } on FirebaseFirestore catch (e){
        throw Exception();
      }
}

final ToDo newToDo = ToDo(
  task: '',
  subTask: '',
  date: '',
  isChecked: false,
  id: '',
);

String uid = FirebaseAuth.instance.currentUser!.uid.toString();
final todo =
    FirebaseFirestore.instance.collection('users').doc(uid).collection('todos');

final _views = Views().views;
final _tabs = Tabs().tabs;
final _todos = TodoCardTitle().todos;

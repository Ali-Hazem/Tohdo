import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/todoCardTitle.dart';
import '/global.dart';
import '../models/toDo.dart';

Future<void> todoDialog(
    {required BuildContext context,
    dateController,
    taskController,
    required InkWell Function({String? date}) tile,
    todoDate,
    List<Widget>? tabs,
    List<Widget>? views,
    newTodo}) {
  final todos = TodoCardTitle().todos;
  const String today = 'Today';
  const String tmrw = 'Tomorrow';
  const String week = 'Next Week';
  return showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text("Your To-Do's name"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "Todo's name",
                      hintStyle: hintStyle,
                      border: InputBorder.none,
                      filled: false,
                    ),
                    style: const TextStyle(fontSize: 22),
                    autofocus: true,
                    controller: taskController,
                  ),
                ),
                const SizedBox(height: 20.0),
                ExpansionTile(
                  title: TextField(
                    autofocus: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      filled: false,
                      hintText: "Todo's deadline",
                      hintStyle: hintStyle,
                    ),
                    style: const TextStyle(fontSize: 18),
                    controller: dateController,
                  ),
                  children: [
                    tile(date: today),
                    tile(date: tmrw),
                    tile(date: week)
                  ],
                ),
              ],
            ),
            actions: [
              OutlinedButton(
                child: Text('Submit',
                    style: TextStyle(
                        color: Colors.blueGrey[800],
                        fontWeight: FontWeight.w900,
                        fontSize: 18)),
                onPressed: () async {
                  QuerySnapshot<Map<String, dynamic>> _query = await todosRef.get();
                  if (dateController.text != '' &&
                      taskController.text != '' &&
                      _query.docs.isNotEmpty) {
                    //add data to firebase;

                    await todosRef.add({
                      'task': taskController.text,
                      'subTask': newTodo.subTask,
                      'date': dateController.text,
                      'isChecked': newTodo.isChecked
                    });
                    // await todoCheck(query: _query);
                    Navigator.pop(context);

                    print(tabs);

                    print(views);

                    taskController.clear();

                    dateController.clear();
                  } else {}
                },
              )
            ],
          ));
}

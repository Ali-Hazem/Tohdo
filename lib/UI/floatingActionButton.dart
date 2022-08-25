import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_project/todoSection/body.dart';
import 'package:flutter/material.dart';
import 'package:first_project/global.dart';
import '../models/toDo.dart';
import '/models/views.dart';
import 'package:first_project/todoSection/models/tabs.dart';
import 'package:provider/provider.dart';
import '/models/todoCardTitle.dart';

floatingActionButton(
    {required BuildContext context,
    dateController,
    taskController,
    required InkWell Function({String? date}) tile,
    todoDate,
    required List<Widget> tabs,
    views,
    void Function()? setState,
    newToDo}) {
  final todos = TodoCardTitle().todos;

  Future? todoCheck({required QuerySnapshot<Map<String, dynamic>> query}) {
    query.docs.forEach((Doc) {
      if (todos.contains(Doc['date'])) {
        //if date already exists;
        context.read<TodoCardTitle>().addTodo(Doc['task']);
      } else {
        //date doesn't exists, so we add a new date to list;
        context.read<TodoCardTitle>().addTodo(Doc['task']);
        context.read<Views>().addView(
            Todo_stream(todoDate: todoDate, views: views, todos: todos));
        context.read<Tabs>().addTabs(Doc['date']);
      }
    });
    return null;
  }

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        const String today = 'Today';
        const String tmrw = 'Tomorrow';
        const String week = 'Next Week';
        showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
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
                        QuerySnapshot<Map<String, dynamic>> _query =
                            await todosRef.get();
                        if (dateController.text != '' &&
                            taskController.text != '' &&
                            _query.docs.isNotEmpty) {
                          //add data to firebase;

                          await todosRef.add({
                            'task': taskController.text,
                            'subTask': newToDo.subTask,
                            'date': dateController.text,
                            'isChecked': newToDo.isChecked
                          });
                          await todoCheck(query: _query);
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
      },
    ),
  );
}


   // if (todoDate.containsKey(dateController.text)) {
                          //   todoDate[dateController.text.toTitleCase()]
                          //       ?.add(taskController.text.toTitleCase());
                          // } else {
                          //   setState(() {
                          //     todoDate[dateController.text.toTitleCase()] =
                          //         [taskController.text.toTitleCase()];
                          //   });
                          // }
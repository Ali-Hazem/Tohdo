import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_project/todoSection/todoCard.dart';
import 'models/toDo.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  final Map<String, dynamic> todoDate;

  final List<Widget> views;
  final List<String> todos;

  const Body(
      {Key? key,
      required this.todoDate,
      required this.views,
      required this.todos})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder<QuerySnapshot>(

          //stream listening to the collection 'todos'
          stream: todo.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            final data = snapshot.requireData;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasError) {
                return const Text('ERROR');
              } else {
                if (snapshot.data!.docs.isEmpty || todos.isEmpty) {
                  return const Center(child: Text('No todos as of now'));
                } else {
                  return ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        for(var todo in todos.toList()){
                          return TodoCard(
                              data, index, context, todoDate,todo, todos);}
                              return const SizedBox();
                        // return TodoCard(data, index, context, todoDate, todos);
                      });
                }
              }
            }
          }),
    );
  }
}

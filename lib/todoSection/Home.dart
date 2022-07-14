// ignore_for_file: deprecated_member_use, prefer_const_literals_to_create_immutables, unused_import, file_names, unnecessary_null_comparison, unused_local_variable, prefer_typing_uninitialized_variables, prefer_const_constructors, unrelated_type_equality_checks

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first_project/authentication/LogIn.dart';
import 'package:first_project/global.dart';
import 'package:first_project/toDo.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoChecked = todo.doc('isChecked');
  void checkStatus(newValue) {
    setState(() {
      todoChecked.update({"isChecked": newValue});
    });
  }

  Checkbox checktodo(data, index) {
    return Checkbox(
        value: newToDo.isChecked,
        onChanged: (newValue) => checkStatus(newValue));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo-App'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Column(children: [
          DrawerHeader(child: Text('To-Do scheduling app')),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                child: Text('Sign-out')),
          )
        ]),
      ),
      body: Container(
        padding: EdgeInsets.all(6),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder<QuerySnapshot>(

            //stream listening to the collection 'todos'
            stream: todo.snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              final data = snapshot.requireData;
              return ListView.builder(
                itemCount: data.size,
                itemBuilder: (context, index) {
                  return Card(
                      elevation: 3.00,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      key: Key(data.docs[index]['task']),
                      child: ListTile(
                        leading: checktodo(data, index),
                        title: Text(
                          data.docs[index]['task'],
                          style: TextStyle(
                              decoration: todoChecked == true
                                  ? TextDecoration.lineThrough
                                  : null),
                        ),
                      ));
                },
              );
            }),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      title: Text("Your To-Do's name"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            decoration: InputDecoration(
                                hintText: "Enter your To-Do's name"),
                            onChanged: (value) => newToDo.task = value,
                            autofocus: true,
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
                          onPressed: () {
                            addtodo();
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ));
          },
          tooltip: 'Add a To-Do',
        ),
      ),
    );
  }
}

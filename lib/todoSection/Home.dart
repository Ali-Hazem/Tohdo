import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_project/toDo.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Checkbox checktodo(data, index) {
    return Checkbox(
        value: data.docs[index]['isChecked'],
        onChanged: (newValue) =>   data.docs[index].reference.update({'isChecked': newValue}));
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
          const DrawerHeader(child: Text('To-Do scheduling app')),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                child: const Text('Sign-out')),
          )
        ]),
      ),
      body: Container(
        padding: const EdgeInsets.all(6),
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
                if (snapshot.hasData) {
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
                                  decoration: newToDo.isChecked == true
                                      ? TextDecoration.lineThrough
                                      : null),
                            ),
                            trailing: InkWell(
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onTap: () {
                                  FirebaseFirestore.instance.runTransaction(
                                      (Transaction myTransaction) async {
                                    myTransaction
                                        .delete(data.docs[index].reference);
                                  });
                                }),
                          ));
                    },
                  );
                } else {
                  return const Text('No todos as of now');
                }
              }
            }),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      title: const Text("Your To-Do's name"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            decoration: const InputDecoration(
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
        ),
      ),
    );
  }
}

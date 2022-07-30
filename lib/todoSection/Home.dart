import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_project/global.dart';
import 'package:first_project/todoSection/toDo.dart';
import 'package:first_project/todoSection/todoCard.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController taskController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  final Map<String, List<String>> todoDate = {
    'today': ['code', 'read a book'],
    //newtodo.date
  };

  Checkbox checktodo(data, index) {
    return Checkbox(
        value: data.docs[index]['isChecked'],
        onChanged: (newValue) =>
            data.docs[index].reference.update({'isChecked': newValue}));
  }

  Widget tile(String date) {
    return InkWell(
      child: SizedBox(
        height: 40,
        child: ListTile(
          title: Text(
            date,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
      onTap: (() {
        setState(() {
          dateController.text = date;
        });
      }),
    );
  }

  @override
  void dispose() {
    taskController.dispose();
    taskController.clear();
    super.dispose();
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
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: data.size,
                    itemBuilder: (context, index) {
                      final String todoKey = todoDate.keys.firstWhere(
                          (k) => todoDate[k] == newToDo.task,
                          orElse: () => 'Error');
                      // return TodoCard(data, index, checktodo, context);
                      for (var key in todoDate.keys) {
                        for (var value in todoDate.values) {
                          return TodoCard(data, index, checktodo, context, todoDate);
                        } return Text(key);
                      }
                      return const Text('');

                    },
                  );
                } else {
                  return const Text('No todos as of now');
                }
              }
            }),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            const String today = 'Today';
            const String week = 'This Week';
            const String month = 'This Month';
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
                              decoration: InputDecoration(
                                hintText: "Todo's name",
                                hintStyle: hintStyle,
                                border: InputBorder.none,
                                filled: false,
                              ),
                              style: const TextStyle(fontSize: 22),
                              onChanged: (value) => newToDo.task = value,
                              autofocus: true,
                              controller: taskController,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          ExpansionTile(
                            title: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                filled: false,
                                hintText: "Todo's deadline",
                                hintStyle: hintStyle,
                              ),
                              style: const TextStyle(fontSize: 18),
                              controller: dateController,
                              onChanged: (value) {
                                newToDo.date = value;
                              },
                            ),
                            children: [tile(today), tile(week), tile(month)],
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
                            //add data to firebase;
                            if (newToDo.task.isNotEmpty && newToDo.task != '') {
                              await todo.add({
                                'task': newToDo.task,
                                'subTask': newToDo.subTask,
                                'createdTime': newToDo.date,
                                'isChecked': newToDo.isChecked,
                              });
                              //
                              todoDate[newToDo.date] = [newToDo.task];

                              Navigator.pop(context);
                              taskController.clear();
                            } else {
                              return;
                            }
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

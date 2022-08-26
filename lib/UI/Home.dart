import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_project/UI/todo_dialog.dart';
import 'package:first_project/global.dart';
import 'package:first_project/models/toDo.dart';
import 'package:flutter/material.dart';
import '/models/tabs.dart';
import 'package:first_project/models/views.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController taskController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController tabController = TextEditingController();

  var todoDate = <String, dynamic>{};
  final tabs = Tabs().tabs;
  final views = Views().views;
  

  @override
  void initState() {
    firstLoadFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: AppBar(
              title: const Text('Todo-App'),
              centerTitle: true,
              actions: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: FloatingActionButton(
                      onPressed: () {
                        context.read<Todo>().deleteTodoCollection(todoDate);
                      },
                      child: const Icon(Icons.delete, color: Colors.red),
                      backgroundColor: Colors.white),
                )
              ],

              //tab bar
              bottom: tabs.isNotEmpty
                  ? TabBar(
                      indicatorColor: Colors.white,
                      tabs: context.watch<Tabs>().tabs,
                    )
                  : null),
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
          body: tabs.isNotEmpty
              ? TabBarView(children: context.watch<Views>().views)
              : appLogo,
          //
          floatingActionButton: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                  child: const Icon(Icons.add),
                  onPressed: () {
                    todoDialog(
                      context: this.context,
                      tile: tile,
                      dateController: dateController,
                      taskController: taskController,
                      tabs: tabs,
                      views: views,
                      newTodo: newTodo,
                    );
                  })),
        ));
  }

  Widget tile({String? date}) {
    return SizedBox(
      height: 40,
      child: ListTile(
        title: Text(
          date ?? 'Null',
          style: const TextStyle(fontSize: 16),
        ),
        onTap: (() {
          if (date != null) {
            setState(() {
              dateController.text = date;
            });
          }
        }),
      ),
    );
  }

Future firstLoadFirebase() async {
  try{
  QuerySnapshot<Map<String, dynamic>> query = await todosRef.limit(1).get(const GetOptions(source: Source.server));

  if (query.docs.isEmpty) {
    Map<String, dynamic> todayDoc = {
      'todo': null,
      'subTask': null,
      'isChecked': null,
      'date': 'Today'
    };
    await todosRef.add(todayDoc);
    context.read<Tabs>().addTabs(todayDoc['date']);
    context.read<Views>().addView(Container());
    print(tabs);
    print(views);
  } } on FirebaseException catch (e){
    throw Exception();
  }
}}

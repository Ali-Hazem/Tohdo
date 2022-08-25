import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_project/global.dart';
import 'package:first_project/todoSection/models/todoCardTitle.dart';
import 'floatingActionButton.dart';
import 'package:first_project/todoSection/models/toDo.dart';
import 'package:flutter/material.dart';
import 'models/tabs.dart';
import 'models/views.dart';
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
  late TabController _controller;

  var todoDate = <String, dynamic>{};
  final tabs = Tabs().tabs;
  final views = Views().views;

  @override
  void dispose() {
    taskController.dispose();
    taskController.clear();
    dateController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getDate(context).then((value) => print(tabs));
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
                        context.read<ToDo>().deleteTodoCollection(todoDate);
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
          floatingActionButton: floatingActionButton(
            context: this.context,
            todoDate: todoDate,
            taskController: taskController,
            dateController: dateController,
            tile: tile,
            tabs: tabs,
            views: views,
            newToDo: newToDo,
          )),
    );
  }

  InkWell tile({String? date}) {
    return InkWell(
      child: SizedBox(
        height: 40,
        child: ListTile(
          title: Text(
            date ?? 'Null',
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
      onTap: (() {
        if (date != null) {
          setState(() {
            dateController.text = date;
          });
        }
      }),
    );
  }}

  Future<void> firstLoadFirebase({ required BuildContext context}) async {
    QuerySnapshot<Map<String, dynamic>> query = await todo.get();
    if (query.docs.toList().isEmpty) {
      await todo.add({
        'todo': newToDo.task,
        'subTask': newToDo.subTask,
        'isChecked': newToDo.isChecked,
        'date': 'Today'
      }).then((doc)=> newToDo.id = doc.id);
      ;
    }
  }
  //wait for firstLoadFirebase function to execute then getDate;
  // so await firstLoadFirebase 

// .then((doc) {
//         newToDo.id = doc.id;
//         // getDate(context, query, doc);
//         doc.get().then((Doc) {
//           context.read<Tabs>().addTabs(Doc['date']);
//           context.read<Views>().addView(Container(
//                 color: Colors.white,
//               ));
//         });
//       });
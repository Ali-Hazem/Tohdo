import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:first_project/todoSection/Home.dart';
import 'package:first_project/authentication/auth.dart';
import 'package:provider/provider.dart';
import 'models/tabs.dart';
import 'models/todo.dart';
import 'models/views.dart';
import 'models/todoCardTitle.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<Tabs>(create: (_) => Tabs()),
        ChangeNotifierProvider<Views>(create: (_) => Views()),
        ChangeNotifierProvider<Todo>(create: (_) => Todo()),
        ChangeNotifierProvider<TodoCardTitle>(create: (_) => TodoCardTitle())
  ],
  child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo-App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: AppBarTheme(color: Colors.blueGrey[800]),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  primary: Colors.blueGrey[800])),
          primaryColorLight: Colors.blueGrey[800],
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.blueGrey[800])),
      home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const Home();
            } else {
              return const Auth();
            }
          }),
    );
  }
}

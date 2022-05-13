// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import, deprecated_member_use, must_be_immutable, override_on_non_overriding_member, avoid_print, use_key_in_widget_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first_project/LogIn.dart';
import 'package:flutter/material.dart';
import 'package:first_project/SignUp.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: FirstPageDecider());
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notion Clone'),
        centerTitle: true,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start
            ,children: [
            InkWell(
              child: Icon(Icons.menu),
              onTap: () {},
            )
          ]),
        ],
      ),
    );
  }
}

class FirstPageDecider extends StatelessWidget {
  const FirstPageDecider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return Home();
    }
    return LogIn();
  }
}

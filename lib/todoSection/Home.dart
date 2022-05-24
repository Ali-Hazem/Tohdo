// ignore_for_file: deprecated_member_use, prefer_const_literals_to_create_immutables, unused_import, file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_project/authentication/LogIn.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo-App'),
        backgroundColor: Colors.blueGrey[800],
        actions: [
          FlatButton.icon(
            onPressed: () async {
              setState(() {});
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => const LogIn())));
            },
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: const Text('Sign In', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }
}

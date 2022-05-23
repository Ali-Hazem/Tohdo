// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables;, deprecated_member_use, unused_local_variable, empty_catches, empty_statements, unused_import, unused_import, duplicate_ignore
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_project/todoSection/Home.dart';
import 'package:first_project/authentication/SignUp.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _emailController1 = TextEditingController();
  final _passwordController1 = TextEditingController();

  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      appBar: AppBar(
          title: Text('Sign In'),
          centerTitle: true,
          backgroundColor: Colors.blueGrey[800]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 86),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  labelText: 'Email',
                ),
                controller: _emailController1,
              ),
              const SizedBox(height: 12),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  labelText: 'Password',
                ),
                controller: _passwordController1,
              ),
              SizedBox(
                height: 15,
                child: Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              Row(
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  InkWell(
                    child: Text(
                      "  Sign Up",
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                  ),
                ],
              ),
              SizedBox(height: 25, child: Text('')),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                child: ElevatedButton(
                    onPressed: () async {
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: _emailController1.text,
                            password: _passwordController1.text);
                            Navigator.pop(context);
                      } on FirebaseAuthException catch (e) {
                        var errorMessage = '';
                        switch (e.code) {
                          case 'invalid-email':
                            errorMessage = 'The email you submitted is wrong';
                            break;
                          case 'user-disabled':
                            errorMessage =
                                'The user you tried to sign into is disabled';
                            break;
                          case 'user-not-found':
                            errorMessage =
                                'The user you tried to sign into is not found';
                            break;
                          case 'wrong-password':
                            errorMessage =
                                'The password you submitted is wrong';
                            break;
                        }
                      }
                      ;
                      setState(() {});
                    },
                    child: Text(
                      'Sign In',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        primary: Colors.blueGrey[800])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

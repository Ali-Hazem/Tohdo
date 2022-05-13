// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables;, deprecated_member_use, unused_local_variable, empty_catches, empty_statements
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:first_project/SignUp.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _emailController1 = TextEditingController();
  final _passwordController1 = TextEditingController();
  String? errorMessage = '';
  
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
              Center(
                child: Text(errorMessage!, style: TextStyle(color: Colors.red)),
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
              const SizedBox(height: 10),
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
              const SizedBox(height: 25),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                child: ElevatedButton(
                    onPressed: () async {
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: _emailController1.text,
                            password: _passwordController1.text);
                        errorMessage = '';
                      } on FirebaseAuthException catch (e) {
                        errorMessage = e.message!;
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

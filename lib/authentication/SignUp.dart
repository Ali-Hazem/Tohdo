// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables;, deprecated_member_use, unused_local_variable, dead_code
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    final _emailController1 = TextEditingController();
    final _passwordController1 = TextEditingController();
    final GlobalKey<FormState> _key = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.grey[350],
      appBar: AppBar(
          title: Text('Sign Up'),
          centerTitle: true,
          backgroundColor: Colors.blueGrey[800]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 86),
              textField('Email', _emailController1),
              const SizedBox(height: 16),
              textField('Password', _passwordController1),
              const SizedBox(height: 25),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                child: ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: _emailController1.text,
                              password: _passwordController1.text);
                      Navigator.of(context).popUntil((route) => route.isFirst);
                      setState(() {});
                    },
                    child: Text(
                      'Sign Up',
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

  Widget textField(String labelValue, var controllerValue) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        labelText: labelValue,
      ),
      controller: controllerValue,
    );
  }
}

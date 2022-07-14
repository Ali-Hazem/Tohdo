// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables;, deprecated_member_use, unused_local_variable, empty_catches, empty_statements, unused_import, unused_import, duplicate_ignore, unused_field
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_project/todoSection/Home.dart';
import 'package:flutter/gestures.dart';
// import 'package:first_project/authentication/signUp.dart';
import 'package:flutter/material.dart';
import 'SignUp.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key, required this.onClickedSignIn}) : super(key: key);
  final VoidCallback onClickedSignIn;

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  // User? user = FirebaseAuth.instance.currentUser;
  String? errorMessage = '';
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('Sign Up'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 86),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  labelText: 'Email',
                ),
                controller: _emailController,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  labelText: 'Password',
                ),
                textInputAction: TextInputAction.next,
                controller: _passwordController,
              ),
              SizedBox(
                height: 19,
                child: Text(
                  errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                    text: TextSpan(
                        text: 'Have an account?  ',
                        style: TextStyle(fontSize: 17, color: Colors.white),
                        children: [
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = widget.onClickedSignIn,
                          //tapGestureRecognizer calls onClickedSignUp
                          text: 'Sign In',
                          style: TextStyle(
                              fontSize: 17,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey[800])),
                    ])),
              ),
              SizedBox(height: 25),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                child: ElevatedButton(
                    onPressed: () async {
                      try {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim());
                      } on FirebaseAuthException catch (e) {
                        errorMessage = e.message;
                      }
                      ;
                      setState(() {});
                    },
                    child: const Text(
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

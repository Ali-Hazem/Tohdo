import 'package:first_project/authentication/signUp.dart';
import 'package:flutter/material.dart';

import 'LogIn.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin
      ? LogIn(
          onClickedSignUp: toggle,
        )
      : SignUp(
          onClickedSignIn: toggle,
        );

  void toggle() {
    setState(() {
      isLogin = !isLogin;
    });
  }
}

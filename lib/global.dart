import 'package:flutter/material.dart';

const flutterLogo = Center(
    child: Image(
  image: AssetImage('assets/flutterLogo.png'),
  fit: BoxFit.cover,
  height: 135,
  width: 100,
));
const authPageText = Center(child: Text('Hello there, welcome to our app!', style: TextStyle(fontSize: 20, color: Colors.white)));
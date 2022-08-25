import 'package:flutter/material.dart';

const appLogo = Center(
    child: Image(
  image: AssetImage('assets/appLogo.png'),
  fit: BoxFit.cover,
  height: 250,
  width: 200,
));
final hintStyle = TextStyle(color: Colors.grey.shade500, fontSize: 22.0);

extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}



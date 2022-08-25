import 'package:flutter/material.dart';

class Views with ChangeNotifier {
  final List<Widget> _views = [];
  List<Widget> get views => _views;
  void addView(Widget widget) {
    _views.add(widget);
    notifyListeners();
  }
}

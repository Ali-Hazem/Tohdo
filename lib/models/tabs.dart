import 'package:flutter/material.dart';

class Tabs with ChangeNotifier {
  final List<Widget> _tabs = [];
  List<Widget> get tabs => _tabs;

  void addTabs(String text) {
    _tabs.add(Tab(text: text));
    notifyListeners();
  }

  void removetabs(String text) {
    _tabs.remove(Tab(text: text));
    notifyListeners();
  }
}

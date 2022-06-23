import 'package:flutter/material.dart';
import 'package:gambling/app/provider/abstract/start_abstract.dart';

class StartProvider extends ChangeNotifier implements StartAbstract{
  var start = false;

  @override
  void changeStart() {
    start = !start;
    debugPrint(start.toString());
    notifyListeners();
  }
}
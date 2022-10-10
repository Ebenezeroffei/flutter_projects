import 'package:flutter/material.dart';

class Counter with ChangeNotifier {
  int _count = 0;
  bool _isNegative = false;

  int get count => _count;

  bool get isNegative => _isNegative;

  increament() {
    _count + 1 >= 0 ? _isNegative = false : _isNegative = true;
    _count++;
    notifyListeners();
  }

  decreament() {
    _count - 1 >= 0 ? _isNegative = false : _isNegative = true;
    _count--;
    notifyListeners();
  }

  reset() {
    _count = 0;
    _isNegative = false;
    notifyListeners();
  }
}

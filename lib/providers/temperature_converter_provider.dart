import 'package:flutter/material.dart';

class TemperatureConverterProvider with ChangeNotifier {
  bool _inputHasText = false;
  double _celsius = 0.00;
  double _kelvin = 0.00;
  double _fahrenheit = 0.00;

  bool get inputHasText => _inputHasText;
  double get celsius => _celsius;
  double get kelvin => _kelvin;
  double get fahrenheit => _fahrenheit;

  void onTextChanged(String value) {
    if (value.isNotEmpty) {
      _inputHasText = true;
      _celsius = double.parse(double.parse(value).toStringAsFixed(2));
      _kelvin = double.parse((double.parse(value) * 274.15).toStringAsFixed(2));
      _fahrenheit =
          double.parse((double.parse(value) * 33.80).toStringAsFixed(2));
    } else {
      _inputHasText = false;
      _celsius = 0.00;
      _kelvin = 0.00;
      _fahrenheit = 0.00;
    }
    notifyListeners();
  }

  void clearInputText(inputController) {
    inputController.clear();
    _inputHasText = false;
    _celsius = 0.00;
    _kelvin = 0.00;
    _fahrenheit = 0.00;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'dart:math';

class TemperatureConverter extends StatefulWidget {
  const TemperatureConverter({Key? key}) : super(key: key);

  @override
  State<TemperatureConverter> createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {
  final TextEditingController inputController = TextEditingController();
  bool inputHasText = false;
  final TextStyle defaultTextStyle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.black87,
  );
  double celsius = 0.00;
  double kelvin = 0.00;
  double fahrenheit = 0.00;

  void onTextChanged(String value) {
    setState(() {
      if (value.isNotEmpty) {
        inputHasText = true;
        celsius = double.parse(double.parse(value).toStringAsFixed(2));
        kelvin =
            double.parse((double.parse(value) * 274.15).toStringAsFixed(2));
        fahrenheit =
            double.parse((double.parse(value) * 33.80).toStringAsFixed(2));
      } else {
        inputHasText = false;
        celsius = 0.00;
        kelvin = 0.00;
        fahrenheit = 0.00;
      }
    });
  }

  void clearInputText() {
    inputController.clear();
    setState(() {
      inputHasText = false;
      celsius = 0.00;
      kelvin = 0.00;
      fahrenheit = 0.00;
    });
  }

  Widget temperatureType(String type, double value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
          elevation: 3,
          child: ListTile(
            leading: const Icon(
              Icons.thermostat,
              size: 30,
              color: Colors.blue,
            ),
            title: Text(
              type,
              style: defaultTextStyle.copyWith(
                  fontSize: 18, fontWeight: FontWeight.w400),
            ),
            subtitle: Text(
              "$value",
              style: defaultTextStyle.copyWith(
                fontSize: 30,
                fontWeight: FontWeight.w400,
                color: Colors.black54,
                letterSpacing: -2,
              ),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Temperature Converter"),
      ),
      body: ListView(
        padding:
            const EdgeInsets.only(top: 30, bottom: 10, left: 15, right: 15),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 5, left: 5),
            child: Text(
              "Enter a value:",
              style: defaultTextStyle,
            ),
          ),
          TextField(
            controller: inputController,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            onChanged: (value) => onTextChanged(value),
            decoration: InputDecoration(
              suffixIcon: inputHasText
                  ? IconButton(
                      icon: const Icon(Icons.close),
                      splashRadius: 15,
                      splashColor: const Color.fromARGB(149, 255, 82, 82),
                      color: Colors.red,
                      onPressed: clearInputText,
                    )
                  : null,
              contentPadding:
                  const EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 10),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: const BorderSide(width: 0.0)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide:
                      const BorderSide(width: 1.5, color: Colors.black)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, top: 30, bottom: 5),
            child: Text(
              "Temperature Conversions:",
              style: defaultTextStyle,
            ),
          ),
          temperatureType("Celsius", celsius),
          temperatureType("Kelvin", kelvin),
          temperatureType("Fahrenheit", fahrenheit),
        ],
      ),
    );
  }
}

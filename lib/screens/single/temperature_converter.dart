import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/temperature_converter_provider.dart';

class TemperatureConverter extends StatelessWidget {
  const TemperatureConverter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TemperatureConverterProvider>(
      create: (_) => TemperatureConverterProvider(),
      child: _TemperatureConverterState(),
    );
  }
}

class _TemperatureConverterState extends StatelessWidget {
  final TextEditingController inputController = TextEditingController();
  final TextStyle defaultTextStyle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.black87,
  );

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
                letterSpacing: -1,
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
            onChanged: (value) => context
                .read<TemperatureConverterProvider>()
                .onTextChanged(value),
            decoration: InputDecoration(
              suffixIcon:
                  context.read<TemperatureConverterProvider>().inputHasText
                      ? IconButton(
                          icon: const Icon(Icons.close),
                          splashRadius: 15,
                          splashColor: const Color.fromARGB(149, 255, 82, 82),
                          color: Colors.red,
                          onPressed: () => context
                              .read<TemperatureConverterProvider>()
                              .clearInputText(inputController),
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
          temperatureType(
              "Celsius", context.watch<TemperatureConverterProvider>().celsius),
          temperatureType(
              "Kelvin", context.watch<TemperatureConverterProvider>().kelvin),
          temperatureType("Fahrenheit",
              context.watch<TemperatureConverterProvider>().fahrenheit),
        ],
      ),
    );
  }
}

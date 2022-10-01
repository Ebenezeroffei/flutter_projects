import 'package:flutter/cupertino.dart';
import 'package:flutter_tuts/screens/home.dart';
import 'package:flutter_tuts/screens/users/main.dart';
import 'package:flutter_tuts/screens/users/register_user.dart';
import './single/show_open_apps.dart';
import './single/temperature_converter.dart';

Map<String, Widget Function(BuildContext)> getRoutes(BuildContext context) {
  return {
    '/': (context) => Home(),
    '/show-open-apps': (context) => ShowOpenApps(),
    '/temperature-converter': (context) => const TemperatureConverter(),
    '/users-register': (context) => const UsersRegister(),
    '/users-register/add': (context) => const RegisterUser(),
  };
}

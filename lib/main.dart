import 'package:flutter/material.dart';
import './screens/routes.dart';

void main() => runApp(_MyApp());

class _MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Tutorials",
      debugShowCheckedModeBanner: false,
      routes: getRoutes(context),
      initialRoute: '/',
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_tuts/screens/dogicon/components.dart';
import 'package:flutter_tuts/screens/dogicon/utils.dart';
import 'package:provider/provider.dart';
import '../../providers/dogicon.dart';

class DogiconApp extends StatelessWidget {
  const DogiconApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DogiconProvider>(
      create: (_) => DogiconProvider(),
      child: _DogiconApp(),
    );
  }
}

class _DogiconApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<DogiconProvider>().allBreeds();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 240, 240),
      body: CustomScrollView(slivers: [
        CustomAppBar(
          breeds: context.read<DogiconProvider>().breeds,
        ),
        Consumer<DogiconProvider>(builder: dogiconHomeConsumer),
      ]),
    );
  }
}

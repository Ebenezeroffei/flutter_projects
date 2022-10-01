import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _appCount = 0;
  List<Widget> _apps = [];
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Get file
    rootBundle.loadString('assets/docs/apps_list.json').then((value) {
      String fileData = value;
      List<dynamic> appsList = jsonDecode(fileData);
      _appCount = appsList.length;
      final apps = <Widget>[];
      for (int i = 0; i < _appCount; i++) {
        Map app = appsList[i];
        apps.add(appLink(context, app['appName'], app['appRoute']));
      }

      setState(() {
        _apps = apps;
      });
    });
  }

  Widget appLink(BuildContext context, String appName, String routeName) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        elevation: 3,
        shadowColor: Colors.black54,
        child: ListTile(
          title: Text(appName),
          onTap: () async {
            Navigator.pushNamed(context, routeName);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Flutter Tutorial Apps"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            controller: scrollController,
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: _appCount,
                  ((context, int index) => _apps[index]),
                ),
              ),
            ],
          ),
        ),
      );
}

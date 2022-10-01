import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ShowOpenApps extends StatelessWidget {
  ShowOpenApps({Key? key}) : super(key: key);

  final TextEditingController search = TextEditingController();

  Widget openedApp() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          height: double.infinity,
          width: 280,
          color: Colors.cyan,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
                child: TextField(
                  controller: search,
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.only(left: 30, right: 30, top: 0, bottom: 0),
                    hintText: "Search",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 50),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    child: Row(
                      children: <Widget>[
                        openedApp(),
                        openedApp(),
                        openedApp(),
                        openedApp(),
                        openedApp(),
                        openedApp(),
                        openedApp(),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 15),
                child: Center(
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(40),
                        ),
                      ),
                      fixedSize: const Size(180, 0),
                      backgroundColor: Colors.black12,
                      surfaceTintColor: Colors.red,
                    ),
                    child: const Text("Close apps"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const <Widget>[
                    Icon(
                      Icons.home,
                      size: 40,
                      color: Colors.blue,
                    ),
                    Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.green,
                    ),
                    Icon(
                      Icons.navigation,
                      size: 40,
                      color: Colors.red,
                    ),
                    Icon(
                      Icons.groups,
                      size: 40,
                      color: Colors.yellow,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
}

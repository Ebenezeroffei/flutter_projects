import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tuts/screens/users/components.dart';
import './extend_widgets.dart';

class UsersRegister extends StatelessWidget {
  const UsersRegister({Key? key}) : super(key: key);

  Future<List<dynamic>> loadUsers() async {
    return await rootBundle.loadStructuredData(
      'assets/docs/users_list.json',
      (value) async {
        return await jsonDecode(value);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users Register"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.pushNamed(context, '/users-register/add');
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        padding:
            const EdgeInsets.only(top: 30, bottom: 20, left: 20, right: 20),
        child: FutureBuilder<List<dynamic>>(
          future: loadUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(
                "Unable to load data",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.black54,
                    ),
              ).centerText();
            } else if (snapshot.hasData) {
              List users = snapshot.requireData;
              switch (users.length) {
                case 0:
                  return Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "No Users Have Been Added.\n",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(height: 1.5, color: Colors.black54),
                        children: <TextSpan>[
                          const TextSpan(text: "Click the "),
                          TextSpan(
                            text: "'+' ",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(fontWeight: FontWeight.w500),
                          ),
                          const TextSpan(text: "Button To Add A User"),
                        ],
                      ),
                    ),
                  );
                default:
                  return Text("Data is available");
              }
            } else {
              return const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

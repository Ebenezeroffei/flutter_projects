import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tuts/screens/users/components.dart';
import 'package:flutter_tuts/screens/users/utils.dart';
import 'package:path_provider/path_provider.dart';
import './extend_widgets.dart';

class UsersRegister extends StatelessWidget {
  const UsersRegister({Key? key}) : super(key: key);

  Future<List<dynamic>> loadUsers() async {
    String filePath =
        "${(await getApplicationDocumentsDirectory()).path}/users_list.json";
    File file = File(filePath);
    if (await file.exists()) {
      // Load users if any
      // TODO: remove the users variable
      List users = await file.readAsString().then((value) => jsonDecode(value));
      // print(users);
      return users;
    } else {
      // create file
      file.create().then(
            (value) => value.writeAsString('[]'),
          );
      return [];
    }
  }

  void deleteUser(BuildContext context, int userId) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              "Delete User",
            ),
            content: const Text("Are you sure you want to delete this user?"),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            actions: <TextButton>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: const Text("Yes"),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.pop(context, false);
                },
                child: const Text("No"),
              ),
            ],
          );
        }).then((value) async {
      if (value) {
        // print("Delete user");
        List users = await getUsers();
        for (Map user in users) {
          if (user['id'] == userId) {
            users = users.where((element) => element['id'] != userId).toList();
          }
        }
        // Write file
        String filepath =
            "${(await getApplicationDocumentsDirectory()).path}/users_list.json";
        File(filepath).writeAsString(jsonEncode(users)).then((value) async {
          Navigator.popAndPushNamed(context, '/users-register');
        });
      }
    });
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
            const EdgeInsets.only(top: 30, bottom: 20, left: 10, right: 10),
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
                  List<Widget> usersListWidget = [];
                  for (Map user in users) {
                    usersListWidget.add(Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Card(
                        elevation: 3,
                        shadowColor: Colors.black54,
                        child: ListTile(
                          title: Text(
                            user['name'],
                          ),
                          subtitle: Text(user['email']),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.edit),
                                splashRadius: 35,
                                color: Colors.blue,
                              ),
                              IconButton(
                                onPressed: () =>
                                    deleteUser(context, user['id']),
                                icon: const Icon(Icons.delete),
                                splashRadius: 35,
                                color: Colors.red,
                              ),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                    ));
                  }
                  return CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                            childCount: usersListWidget.length,
                            (context, int index) => usersListWidget[index]),
                      ),
                    ],
                  );
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

import 'dart:io';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';

Future<List> getUsers() async {
  String filepath =
      "${(await getApplicationDocumentsDirectory()).path}/users_list.json";
  File file = File(filepath);
  return file.readAsString().then((value) => jsonDecode(value));
}

Future<dynamic> getUser(int userId) async {
  List users = await getUsers();
  for (Map user in users) {
    if (user['id'] == userId) return user;
  }
  return 'false';
}

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import './components.dart';
import './extend_widgets.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({Key? key}) : super(key: key);

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController =
      TextEditingController(text: 'Ebenezer Offei');
  final TextEditingController _emailController =
      TextEditingController(text: 'eoffei@outlook.com');
  final TextEditingController _descriptionController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<bool> isEmailUnique(String email) async {
    String fileData =
        await rootBundle.loadString('assets/docs/users_list.json');
    List users = await jsonDecode(fileData);
    if (users.isNotEmpty) {
      return false;
    }
    return true;
  }

  Future<List> getUsers() async {
    return await rootBundle.loadStructuredData('assets/docs/users_list.json',
        (value) {
      return jsonDecode(value);
    });
  }

  Future<void> saveUser(user) async {
    List users = await getUsers();
    users.add(user);
    String encodedUsersData = jsonEncode(users);
    File('../assets/docs/users_list.json')
        .writeAsString(encodedUsersData)
        .then((value) async {
      Navigator.pushNamed(context, '/users-register');
    }).onError((error, stackTrace) {
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("There app has encounted an error. Try again later.")));
    });
  }

  void submit() async {
    try {
      setState(() {
        _isLoading = true; // Form is loading
      });
      // await Future.delayed(Duration(seconds: 2));
      // TODO: Validate input daata
      if (_formKey.currentState!.validate()) {
        String name = _nameController.text;
        String email = _emailController.text;
        String description = _descriptionController.text;
        if (await isEmailUnique(email)) {
          Map<String, dynamic> user = {
            'name': name,
            'email': email,
            'description': description,
          };
          // await saveUser(user);
          // print(await File('components.dart').exists());
          print((await getApplicationDocumentsDirectory()).path);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("The email is not unique."),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Users Register"),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: <Widget>[
              Text(
                "Add User",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 30),
              CustomTextField(
                controller: _nameController,
                labelText: "Name:",
                helperText: "Enter your full name",
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'[A-Za-z\s-\.]'),
                  ),
                ],
                validator: (value) {
                  if (!value!.isValidName) {
                    return "Please provide your full name, eg. Someone Somewhere";
                  }
                  return null;
                },
              ),
              CustomTextField(
                labelText: "Email:",
                controller: _emailController,
                helperText: "Enter your email, eg. someone@you.com",
                validator: (value) {
                  if (!value!.isValidEmail) {
                    return "Enter a valid email.";
                  }
                  return null;
                },
              ),
              CustomTextField(
                labelText: "Description:",
                controller: _descriptionController,
                helperText: 'Say something about the user.',
                inputRequired: false,
                isTextArea: true,
              ),
              _isLoading ? Button.progress() : Button.text("Submit", submit),
            ],
          ),
        ));
  }
}

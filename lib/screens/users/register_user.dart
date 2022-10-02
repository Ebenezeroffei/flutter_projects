import 'dart:convert';
import 'dart:io';
import 'dart:math';

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
  String _filePath = "";
  final List _usersEmails = [];

  @override
  void initState() {
    super.initState();
    getApplicationDocumentsDirectory().then((value) {
      _filePath = "${value.path}/users_list.json";
      File file = File(_filePath);
      file.readAsString().then((value) {
        List users = jsonDecode(value);
        if (users.isNotEmpty) {
          for (Map user in users) {
            _usersEmails.add(user['email']);
          }
        }
      });
    });
  }

  Future<void> saveUser(user) async {
    File file = File(_filePath);
    // Get all users
    String fileData = await file.readAsString();
    List users = jsonDecode(fileData);
    users.add(user);
    // Save user
    file.writeAsString(jsonEncode(users)).then((value) async {
      // Go to users page
      Navigator.pushReplacementNamed(context, '/users-register');
    }).onError((error, stackTrace) {
      // Show error while saving
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text("There was a problem saving the user into the database"),
          duration: Duration(
            seconds: 1,
            milliseconds: 50,
          ),
        ),
      );
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
        // String name = _nameController.text;
        // String email = _emailController.text;
        // String description = _descriptionController.text;
        int userId = Random().nextInt(9999);
        Map<String, dynamic> user = {
          'name': _nameController.text,
          'email': _emailController.text,
          'description': _descriptionController.text,
          'id': userId,
        };
        saveUser(user);
      }
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
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
                  value = value?.trim();
                  if (!value!.isValidEmail) {
                    return "Enter a valid email.";
                  }
                  if (value.emailNotUnique(_usersEmails)) {
                    return "The email entered has been taken by another user";
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

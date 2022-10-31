import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import '../screens/users/components.dart';
import '../screens/users/extend_widgets.dart';

class RegisterUserProvider with ChangeNotifier {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController =
      TextEditingController(text: 'Ebenezer Offei');
  final TextEditingController _emailController =
      TextEditingController(text: 'eoffei@outlook.com');
  final TextEditingController _descriptionController = TextEditingController();
  bool _isLoading = false;
  String _filePath = "";
  final List _usersEmails = [];

  bool get isLoading => _isLoading;
  List get usersEmails => _usersEmails;
}

// class CustomTextFieldProvider with ChangeNotifier {

// }

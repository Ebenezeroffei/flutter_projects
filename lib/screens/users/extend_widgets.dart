import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

extension ExtendTextWidget on Widget {
  centerText() {
    return Center(
      child: this,
    );
  }

  leftAlign() {
    return Align(
      alignment: Alignment.centerLeft,
      child: this,
    );
  }
}

extension FormValidators on String {
  bool get isValidName {
    RegExp validNameRegex = RegExp(
        r'^[a-zA-Z]{3,}\s+(([a-zA-Z]\.\s+)?)*([a-zA-Z](-[a-zA-Z])?(\s+)?)+$');
    return validNameRegex.hasMatch(this);
  }

  bool get isValidEmail {
    RegExp validEmailRegexp =
        RegExp(r'^[a-zA-Z][a-zA-Z\d]+@[a-z]+\.[a-z]{3,}(\.[a-z]{2,})?(\s+)?$');
    return validEmailRegexp.hasMatch(this);
  }

  bool emailNotUnique(List emails) {
    return emails.contains(this);
  }
}

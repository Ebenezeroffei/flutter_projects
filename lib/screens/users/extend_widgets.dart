import 'package:flutter/material.dart';

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
}

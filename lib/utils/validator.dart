// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter/widgets.dart';

class Validator {
  static FormFieldValidator<String> email = (email) {
    if (email == null || email.isEmpty) {
      return 'Email is required.';
    }

    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(email)) {
      return 'The email you entered is invalid.';
    }

    return null;
  };

  static FormFieldValidator<String> password = (password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }

    if (password.length < 7) {
      return "Password is invalid.";
    }

    return null;
  };

  static FormFieldValidator<String> title = (title) {
    if (title == null || title.isEmpty) {
      return 'Title is required';
    }

    if (title.length < 5) {
      return "Title should be more than five letters.";
    }

    return null;
  };

  static FormFieldValidator<String> content = (content) {
    if (content == null || content.isEmpty) {
      return 'Content is required';
    }

    if (content.length < 10) {
      return "Content should be more than ten letters.";
    }

    return null;
  };
}

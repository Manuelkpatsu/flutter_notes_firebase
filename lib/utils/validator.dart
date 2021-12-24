// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter/widgets.dart';
import 'package:notesapp/generated/l10n.dart';

class Validator {
  static FormFieldValidator<String> email = (email) {
    if (email == null || email.isEmpty) {
      return S.current.emailRequired;
    }

    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(email)) {
      return S.current.invalidEmail;
    }

    return null;
  };

  static FormFieldValidator<String> password = (password) {
    if (password == null || password.isEmpty) {
      return S.current.passwordRequired;
    }

    if (password.length < 7) {
      return S.current.invalidPassword;
    }

    return null;
  };

  static FormFieldValidator<String> title = (title) {
    if (title == null || title.isEmpty) {
      return S.current.titleRequired;
    }

    if (title.length < 5) {
      return S.current.maxTitle;
    }

    return null;
  };

  static FormFieldValidator<String> content = (content) {
    if (content == null || content.isEmpty) {
      return S.current.contentRequired;
    }

    if (content.length < 10) {
      return S.current.maxContent;
    }

    return null;
  };
}

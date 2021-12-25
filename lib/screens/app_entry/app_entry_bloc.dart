import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:notesapp/repository/user_repository.dart';

import 'app_entry_model_data.dart';

class AppEntryBloc extends ValueNotifier<AppEntryModelData> {
  final _logger = Logger();
  final UserRepository _userRepository;

  AppEntryBloc(this._userRepository) : super(const AppEntryModelData()) {
    isUserSignedIn();
  }

  void isUserSignedIn() {
    _userRepository.isSignedIn().then((isSignedIn) {
      value = value.copyWith(isSignedIn: isSignedIn);
    }).catchError((error) {
      _logger.e('Error checking whether user is signed in', error);
    });
  }
}

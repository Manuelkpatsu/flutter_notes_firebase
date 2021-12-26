import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:notesapp/repository/user_repository.dart';
import 'package:notesapp/utils/helper.dart';

import '../auth_flow_coordinator.dart';
import 'sign_up_event.dart';
import 'sign_up_model_data.dart';

class SignUpBloc extends ValueNotifier<SignUpModelData> {
  final _logger = Logger();
  final BuildContext _context;
  final StreamController<SignUpEvent> _eventController;
  final UserRepository _userRepository;
  final AuthFlowCoordinator _authFlowCoordinator;

  SignUpBloc(
    this._context,
    this._eventController,
    this._userRepository,
    this._authFlowCoordinator,
  ) : super(const SignUpModelData()) {
    _eventController.stream
        .listen((event) => _handleEvent(event))
        .onError((error) => _logger.e('Error responding to event', error));
  }

  /// Handles [SignUpEvent]
  void _handleEvent(SignUpEvent event) {
    switch (event.runtimeType) {
      case SignUpUserEvent:
        final signUpUserEvent = event as SignUpUserEvent;
        _createNewUser(signUpUserEvent.email, signUpUserEvent.password);
        break;
      case GoToLoginScreenEvent:
        _authFlowCoordinator.goToLoginScreen();
        break;
    }
  }

  void _createNewUser(String email, String password) {
    value = value.copyWith(signingUp: true);

    _userRepository
        .registerAccount(email, password)
        .then(
            (userCredential) => _authFlowCoordinator.goToHomeScreenAfterAuthentication())
        .whenComplete(() => value = value.copyWith(signingUp: false))
        .catchError((error) {
      FirebaseAuthException exception = error;
      String? errorMessage;

      switch (exception.code) {
        case 'weak-password':
          errorMessage = 'The password provided is too weak.';
          break;
        case 'email-already-in-use':
          errorMessage = 'The account already exists for that email.';
          break;
        case 'network-request-failed':
          errorMessage = 'Make sure you have a stable connection and try again';
          break;
        default:
          errorMessage = 'An error occurred. Please try again';
          break;
      }

      Helper.showSnackbar(_context, errorMessage, Colors.red);
    });
  }

  @override
  void dispose() {
    _eventController.close();
    super.dispose();
  }
}

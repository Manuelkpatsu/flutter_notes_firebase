import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:notesapp/repository/user_repository.dart';
import 'package:notesapp/utils/helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth_flow_coordinator.dart';
import 'login_event.dart';
import 'login_model_data.dart';

class LoginBloc extends ValueNotifier<LoginModelData> {
  final _logger = Logger();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final BuildContext _context;
  final StreamController<LoginEvent> _eventController;
  final UserRepository _userRepository;
  final AuthFlowCoordinator _authFlowCoordinator;

  LoginBloc(
    this._context,
    this._eventController,
    this._userRepository,
    this._authFlowCoordinator,
  ) : super(const LoginModelData()) {
    _eventController.stream
        .listen((event) => _handleEvent(event))
        .onError((error) => _logger.e('Error responding to event', error));
  }

  /// Handles [LoginEvent]
  void _handleEvent(LoginEvent event) {
    switch (event.runtimeType) {
      case LoginUserEvent:
        final loginUserEvent = event as LoginUserEvent;
        _signIn(loginUserEvent.email, loginUserEvent.password);
        break;
      case GoToSignUpScreenEvent:
        _authFlowCoordinator.goToSignUpScreen();
        break;
      case GoToForgotPasswordScreenEvent:
        _authFlowCoordinator.goToForgotPasswordScreen();
        break;
    }
  }

  void _signIn(String email, String password) {
    value = value.copyWith(signingIn: true);

    _userRepository
        .login(email, password)
        .then((userCredential) {
          _prefs.then((SharedPreferences prefs) {
            prefs.setString('userId', userCredential.user!.uid);
            _authFlowCoordinator.goToHomeScreenAfterAuthentication();
          });
        })
        .whenComplete(() => value = value.copyWith(signingIn: false))
        .catchError((error) {
          FirebaseAuthException exception = error;
          String? errorMessage;

          switch (exception.code) {
            case 'user-not-found':
              errorMessage = 'No user found for this email';
              break;
            case 'wrong-password':
              errorMessage = 'Sorry, wrong credentials provided';
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

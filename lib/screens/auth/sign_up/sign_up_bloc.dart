import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:notesapp/repository/user_repository.dart';
import 'package:notesapp/utils/helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:notesapp/generated/l10n.dart';

import '../auth_flow_coordinator.dart';
import 'sign_up_event.dart';
import 'sign_up_model_data.dart';

class SignUpBloc extends ValueNotifier<SignUpModelData> {
  final _logger = Logger();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
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
        .onError((error) => _logger.e(S.current.errorRespondingToEvent, error));
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
        .then((userCredential) {
          _prefs.then((SharedPreferences prefs) {
            prefs.setString('userId', userCredential.user!.uid);
            _authFlowCoordinator.goToHomeScreenAfterAuthentication();
          });
        })
        .whenComplete(() => value = value.copyWith(signingUp: false))
        .catchError((error) {
          FirebaseAuthException exception = error;
          String? errorMessage;

          switch (exception.code) {
            case 'weak-password':
              errorMessage = S.current.weakPassword;
              break;
            case 'email-already-in-use':
              errorMessage = S.current.emailAlreadyInUse;
              break;
            case 'network-request-failed':
              errorMessage = S.current.networkConnectionIssue;
              break;
            default:
              errorMessage = S.current.tryAgain;
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

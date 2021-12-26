import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:notesapp/repository/user_repository.dart';
import 'package:notesapp/utils/helper.dart';

import '../auth_flow_coordinator.dart';
import 'forgot_password_event.dart';
import 'forgot_password_model_data.dart';

class ForgotPasswordBloc extends ValueNotifier<ForgotPasswordModelData> {
  final _logger = Logger();
  final BuildContext _context;
  final StreamController<ForgotPasswordEvent> _eventController;
  final UserRepository _userRepository;
  final AuthFlowCoordinator _authFlowCoordinator;

  ForgotPasswordBloc(
    this._context,
    this._eventController,
    this._userRepository,
    this._authFlowCoordinator,
  ) : super(const ForgotPasswordModelData()) {
    _eventController.stream
        .listen((event) => _handleEvent(event))
        .onError((error) => _logger.e('Error responding to event', error));
  }

  /// Handles [ForgotPasswordEvent]
  void _handleEvent(ForgotPasswordEvent event) {
    switch (event.runtimeType) {
      case ResetPasswordEvent:
        final resetPasswordEvent = event as ResetPasswordEvent;
        _resetPassword(resetPasswordEvent.email);
        break;
    }
  }

  void _resetPassword(String email) {
    value = value.copyWith(requestingResetPasswordLink: true);

    _userRepository
        .resetPassword(email)
        .then((userCredential) =>
            _authFlowCoordinator.goToLoginScreenAfterRequestingPasswordChangeLink())
        .whenComplete(() => value = value.copyWith(requestingResetPasswordLink: false))
        .catchError((error) {
      FirebaseAuthException exception = error;
      String? errorMessage;

      switch (exception.code) {
        case 'user-not-found':
          errorMessage = 'No user found for this email';
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

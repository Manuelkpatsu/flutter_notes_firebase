import 'package:flutter/material.dart';

abstract class LoginEvent {}

@immutable
class LoginUserEvent extends LoginEvent {
  final String email;
  final String password;

  LoginUserEvent(this.email, this.password);
}

class GoToSignUpScreenEvent extends LoginEvent {}

class GoToForgotPasswordScreenEvent extends LoginEvent {}

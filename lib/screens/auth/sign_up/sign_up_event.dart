import 'package:flutter/material.dart';

abstract class SignUpEvent {}

@immutable
class SignUpUserEvent extends SignUpEvent {
  final String email;
  final String password;

  SignUpUserEvent(this.email, this.password);
}

class GoToLoginScreenEvent extends SignUpEvent {}

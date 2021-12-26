import 'package:flutter/material.dart';

abstract class ForgotPasswordEvent {}

@immutable
class ResetPasswordEvent extends ForgotPasswordEvent {
  final String email;

  ResetPasswordEvent(this.email);
}

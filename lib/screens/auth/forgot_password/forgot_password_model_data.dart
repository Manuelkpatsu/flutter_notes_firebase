import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

@immutable
class ForgotPasswordModelData extends Equatable {
  final bool requestingResetPasswordLink;

  const ForgotPasswordModelData({this.requestingResetPasswordLink = false});

  ForgotPasswordModelData copyWith({bool? requestingResetPasswordLink}) {
    return ForgotPasswordModelData(
        requestingResetPasswordLink:
            requestingResetPasswordLink ?? this.requestingResetPasswordLink);
  }

  @override
  List<Object?> get props => [requestingResetPasswordLink];
}

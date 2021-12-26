import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

@immutable
class LoginModelData extends Equatable {
  final bool signingIn;

  const LoginModelData({this.signingIn = false});

  LoginModelData copyWith({bool? signingIn}) {
    return LoginModelData(signingIn: signingIn ?? this.signingIn);
  }

  @override
  List<Object?> get props => [signingIn];
}

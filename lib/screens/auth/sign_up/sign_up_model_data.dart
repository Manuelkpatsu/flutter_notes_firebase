import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

@immutable
class SignUpModelData extends Equatable {
  final bool signingUp;

  const SignUpModelData({this.signingUp = false});

  SignUpModelData copyWith({bool? signingUp}) {
    return SignUpModelData(signingUp: signingUp ?? this.signingUp);
  }

  @override
  List<Object?> get props => [signingUp];
}

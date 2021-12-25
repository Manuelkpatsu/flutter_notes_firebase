import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class AppEntryModelData extends Equatable {
  final bool isSignedIn;

  const AppEntryModelData({this.isSignedIn = false});

  AppEntryModelData copyWith({bool? isSignedIn}) {
    return AppEntryModelData(
      isSignedIn: isSignedIn ?? this.isSignedIn,
    );
  }

  @override
  List<Object?> get props => [isSignedIn];
}

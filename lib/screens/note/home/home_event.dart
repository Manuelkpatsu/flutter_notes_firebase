import 'package:flutter/material.dart';

abstract class HomeEvent {}

class GoToSearchScreenEvent extends HomeEvent {}

class LogoutEvent extends HomeEvent {}

@immutable
class ToggleLayoutEvent extends HomeEvent {
  final bool isGrid;

  ToggleLayoutEvent(this.isGrid);
}

class GoToAddNoteScreenEvent extends HomeEvent {}

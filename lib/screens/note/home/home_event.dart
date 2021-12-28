import 'package:flutter/material.dart';
import 'package:notesapp/screens/note/add_update_note/note_arguments.dart';

abstract class HomeEvent {}

class GoToSearchScreenEvent extends HomeEvent {}

class LogoutEvent extends HomeEvent {}

@immutable
class GoToAddNoteScreenEvent extends HomeEvent {
  final NoteArguments arguments;

  GoToAddNoteScreenEvent(this.arguments);
}

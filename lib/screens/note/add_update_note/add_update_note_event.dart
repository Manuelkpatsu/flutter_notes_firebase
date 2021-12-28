import 'package:flutter/material.dart';
import 'package:notesapp/model/note.dart';

abstract class AddUpdateNoteEvent {}

@immutable
class UpdateNoteEvent extends AddUpdateNoteEvent {
  final String? noteId;
  final Note note;

  UpdateNoteEvent(this.noteId, this.note);
}

@immutable
class CreateNoteEvent extends AddUpdateNoteEvent {
  final Note note;

  CreateNoteEvent(this.note);
}

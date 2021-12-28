import 'package:flutter/material.dart';

abstract class SearchNoteTileEvent {}

@immutable
class GoToViewNoteScreenEvent extends SearchNoteTileEvent {
  final String id;

  GoToViewNoteScreenEvent(this.id);
}

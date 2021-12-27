import 'package:flutter/material.dart';

abstract class HomeTileEvent {}

@immutable
class GoToViewNoteScreenEvent extends HomeTileEvent {
  final String id;

  GoToViewNoteScreenEvent(this.id);
}

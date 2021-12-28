import 'package:flutter/material.dart';

abstract class SearchEvent {}

@immutable
class SearchNoteEvent extends SearchEvent {
  final String searchQuery;

  SearchNoteEvent(this.searchQuery);
}

class ClearSearchQueryEvent extends SearchEvent {}

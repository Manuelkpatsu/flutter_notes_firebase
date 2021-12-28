import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class SearchNoteTileModelData extends Equatable {
  final String id;
  final String title;
  final String description;
  final int color;
  final int priority;
  final String date;

  const SearchNoteTileModelData({
    required this.id,
    required this.title,
    required this.description,
    this.color = 0,
    this.priority = 3,
    required this.date,
  });

  @override
  List<Object?> get props => [id, title, description, color, priority, date];
}

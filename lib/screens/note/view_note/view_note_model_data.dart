import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class ViewNoteModelData extends Equatable {
  final String noteId;
  final String title;
  final String description;
  final String userId;
  final int color;
  final int priority;
  final String date;
  final String message;
  final bool loading;

  const ViewNoteModelData({
    this.noteId = '',
    this.title = '',
    this.description = '',
    this.userId = '',
    this.color = 0,
    this.priority = 3,
    this.date = '2021-12-23T04:59:07.389+00:00',
    this.message = '',
    this.loading = false,
  });

  ViewNoteModelData copyWith({
    String? noteId,
    String? title,
    String? description,
    String? userId,
    int? color,
    int? priority,
    String? date,
    String? message,
    bool? loading,
  }) {
    return ViewNoteModelData(
      noteId: noteId ?? this.noteId,
      title: title ?? this.title,
      description: description ?? this.description,
      userId: userId ?? this.userId,
      color: color ?? this.color,
      priority: priority ?? this.priority,
      date: date ?? this.date,
      message: message ?? this.message,
      loading: loading ?? this.loading,
    );
  }

  @override
  List<Object?> get props => [
        noteId,
        title,
        description,
        userId,
        color,
        priority,
        date,
        message,
        loading,
      ];
}

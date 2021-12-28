import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class AddUpdateNoteModelData extends Equatable {
  final bool saving;

  const AddUpdateNoteModelData({this.saving = false});

  AddUpdateNoteModelData copyWith({bool? saving}) {
    return AddUpdateNoteModelData(saving: saving ?? this.saving);
  }

  @override
  List<Object?> get props => [saving];
}

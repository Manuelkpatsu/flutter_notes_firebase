import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'home_tile_model_data.dart';

@immutable
class HomeModelData extends Equatable {
  final List<HomeTileModelData> notes;
  final String message;
  final bool loading;
  final bool isGrid;

  const HomeModelData({
    this.notes = const [],
    this.message = '',
    this.isGrid = true,
    this.loading = false,
  });

  HomeModelData copyWith({
    List<HomeTileModelData>? notes,
    String? message,
    bool? loading,
    bool? isGrid,
  }) {
    return HomeModelData(
      notes: notes ?? this.notes,
      message: message ?? this.message,
      isGrid: isGrid ?? this.isGrid,
      loading: loading ?? this.loading,
    );
  }

  @override
  List<Object?> get props => [notes, message, isGrid];
}

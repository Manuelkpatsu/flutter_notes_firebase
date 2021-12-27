import 'dart:async';

import 'package:notesapp/model/note.dart';
import 'package:notesapp/repository/note_repository.dart';

import 'home_model_data.dart';
import 'home_tile_model_data.dart';

class HomeDomainModel {
  final _homeNotesController = StreamController<HomeModelData>();
  final NoteRepository _noteRepository;

  HomeDomainModel(this._noteRepository);

  Stream<HomeModelData> getNotesStream(String userId) {
    if (!_homeNotesController.hasListener) {
      _refreshData(userId);
    }
    return _homeNotesController.stream.distinct();
  }

  void _refreshData(String userId) {
    _noteRepository.getNoteList(userId).then((notes) {
      List<HomeTileModelData> list =
          notes.map((note) => _noteToTileModelData(note)).toList();
      _homeNotesController.add(HomeModelData(notes: list));
    });
  }

  HomeTileModelData _noteToTileModelData(Note note) {
    return HomeTileModelData(
      id: note.id,
      title: note.title,
      description: note.description,
      color: note.color,
      priority: note.priority,
      date: note.getDate(note.createdAt),
    );
  }

  void dispose() {
    _homeNotesController.close();
  }
}

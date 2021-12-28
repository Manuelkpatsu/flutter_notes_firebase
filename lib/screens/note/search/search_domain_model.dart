import 'dart:async';

import 'package:notesapp/repository/note_repository.dart';

import 'search_note_tile_model_data.dart';

class SearchDomainModel {
  final _searchNoteController = StreamController<List<SearchNoteTileModelData>>();
  final NoteRepository _noteRepository;

  SearchDomainModel(this._noteRepository);

  Stream<List<SearchNoteTileModelData>> getSearchNoteTileModelDataListStream(
      String userId) {
    if (!_searchNoteController.hasListener) {
      _refreshData(userId);
    }
    return _searchNoteController.stream.distinct();
  }

  void _refreshData(String userId) {
    _noteRepository.getNoteList(userId).then((notes) {
      List<SearchNoteTileModelData> list = notes
          .map((note) => SearchNoteTileModelData(
                id: note.id!,
                title: note.title,
                description: note.description,
                date: note.getDate(note.createdAt!),
                color: note.color,
                priority: note.priority,
              ))
          .toList();
      _searchNoteController.add(list);
    });
  }

  void dispose() {
    _searchNoteController.close();
  }
}

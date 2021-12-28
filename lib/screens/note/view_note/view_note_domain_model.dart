import 'dart:async';

import 'package:notesapp/repository/note_repository.dart';

import 'view_note_model_data.dart';

class ViewNoteDomainModel {
  final _modelDataController = StreamController<ViewNoteModelData?>();
  final NoteRepository _noteRepository;

  ViewNoteDomainModel(this._noteRepository);

  Stream<ViewNoteModelData?> getNoteStream(String noteId) {
    if (!_modelDataController.hasListener) {
      _refreshData(noteId);
    }
    return _modelDataController.stream.distinct();
  }

  void _refreshData(String noteId) {
    _noteRepository.getNote(noteId).then((note) {
      ViewNoteModelData modelData = ViewNoteModelData(
        noteId: note.id!,
        title: note.title,
        description: note.description,
        userId: note.userId,
        color: note.color,
        priority: note.priority,
        date: note.getDate(note.createdAt!),
      );
      _modelDataController.add(modelData);
    });
  }

  Future<void> removeNote(String noteId) {
    return _noteRepository.deleteNote(noteId);
  }

  void dispose() {
    _modelDataController.close();
  }
}

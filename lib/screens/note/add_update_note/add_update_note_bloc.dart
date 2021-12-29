import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:notesapp/generated/l10n.dart';
import 'package:notesapp/model/note.dart';
import 'package:notesapp/repository/note_repository.dart';
import 'package:notesapp/utils/helper.dart';

import '../note_flow_coordinator.dart';
import 'add_update_note_event.dart';
import 'add_update_note_model_data.dart';

class AddUpdateNoteBloc extends ValueNotifier<AddUpdateNoteModelData> {
  final _logger = Logger();
  final BuildContext _context;
  final StreamController<AddUpdateNoteEvent> _eventController;
  final NoteRepository _noteRepository;
  final NoteFlowCoordinator _noteFlowCoordinator;

  AddUpdateNoteBloc(
    this._context,
    this._eventController,
    this._noteRepository,
    this._noteFlowCoordinator,
  ) : super(const AddUpdateNoteModelData()) {
    _eventController.stream
        .listen((event) => _handleEvent(event))
        .onError((error) => _logger.e(S.current.errorRespondingToEvent, error));
  }

  /// Handles [AddUpdateNoteEvent]
  void _handleEvent(AddUpdateNoteEvent event) {
    switch (event.runtimeType) {
      case UpdateNoteEvent:
        final updateNoteEvent = event as UpdateNoteEvent;
        _updateNote(updateNoteEvent.noteId!, updateNoteEvent.note);
        break;
      case CreateNoteEvent:
        final createNoteEvent = event as CreateNoteEvent;
        _addNewNote(createNoteEvent.note);
        break;
    }
  }

  void _updateNote(String noteId, Note note) {
    value = value.copyWith(saving: true);

    _noteRepository.updateNote(noteId, note).then((_) {
      Helper.showSnackbar(
        _context,
        S.current.noteSaved,
        Colors.green,
      );
      _noteFlowCoordinator.goToHomeScreenAfterSavingNote();
    }).catchError((error) {
      Helper.showSnackbar(
        _context,
        S.current.tryAgain,
        Colors.red.shade900,
      );
    }).whenComplete(() => value = value.copyWith(saving: false));
  }

  void _addNewNote(Note note) {
    value = value.copyWith(saving: true);

    _noteRepository.addNote(note).then((_) {
      Helper.showSnackbar(
        _context,
        S.current.noteSaved,
        Colors.green,
      );
      _noteFlowCoordinator.goToHomeScreenAfterSavingNote();
    }).catchError((error) {
      Helper.showSnackbar(
        _context,
        S.current.tryAgain,
        Colors.red.shade900,
      );
    }).whenComplete(() => value = value.copyWith(saving: false));
  }

  @override
  void dispose() {
    _eventController.close();
    super.dispose();
  }
}

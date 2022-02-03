import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:notesapp/generated/l10n.dart';
import 'package:notesapp/utils/helper.dart';

import '../note_flow_coordinator.dart';
import 'view_note_domain_model.dart';
import 'view_note_event.dart';
import 'view_note_model_data.dart';

class ViewNoteBloc extends ValueNotifier<ViewNoteModelData> {
  final _logger = Logger();
  final BuildContext _context;
  final StreamController<ViewNoteEvent> _eventController;
  final String _noteId;
  final ViewNoteDomainModel _noteDomainModel;
  final NoteFlowCoordinator _noteFlowCoordinator;

  ViewNoteBloc(
    this._context,
    this._eventController,
    this._noteId,
    this._noteDomainModel,
    this._noteFlowCoordinator,
  ) : super(const ViewNoteModelData()) {
    value = value.copyWith(loading: true);
    _noteDomainModel.getNoteStream(_noteId).listen((modelData) {
      value = value.copyWith(loading: false);
      _refreshUI(modelData);
    }).onError((error) {
      value =
          value.copyWith(loading: false, message: S.current.errorLoadingNotes);
      _logger.e(S.current.errorLoadingNotes, error);
    });

    _eventController.stream
        .listen((event) => _handleEvent(event))
        .onError((error) {
      _logger.e(S.current.errorRespondingToEvent, error);
    });
  }

  /// Updates the UI
  ///
  /// [modelData] new data to update to
  void _refreshUI(ViewNoteModelData? modelData) {
    if (modelData != null) {
      value = value.copyWith(
        noteId: modelData.noteId,
        title: modelData.title,
        description: modelData.description,
        userId: modelData.userId,
        color: modelData.color,
        priority: modelData.priority,
        date: modelData.date,
      );
    } else {
      _logger.w(S.current.noteDoesNotExist);
    }
  }

  /// Handles [ViewPaymentMethodEvent]s
  ///
  /// [event] Event to handle
  void _handleEvent(ViewNoteEvent event) {
    switch (event.runtimeType) {
      case DeleteNoteEvent:
        _removeNote();
        break;
      case EditNoteEvent:
        final editNoteEvent = event as EditNoteEvent;
        _noteFlowCoordinator.goToUpdateNoteScreen(editNoteEvent.arguments);
        break;
    }
  }

  /// Removes the payment method
  void _removeNote() {
    Helper.showAlertDialog(
      _context,
      S.current.deleteNote,
      () {
        _noteFlowCoordinator.pop();
        _noteDomainModel.removeNote(_noteId).then((_) {
          Helper.showSnackbar(
            _context,
            S.current.successfullyDeleted,
            Colors.green,
          );
          _noteFlowCoordinator.goToHomeScreenAfterDeletion();
        }).catchError((error) {
          _logger.e(S.current.tryAgain, error);
          Helper.showSnackbar(_context, S.current.tryAgain, Colors.red);
        });
      },
    );
  }

  @override
  void dispose() {
    _noteDomainModel.dispose();
    _eventController.close();
    super.dispose();
  }
}

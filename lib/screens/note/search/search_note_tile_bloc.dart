import 'dart:async';

import 'package:logger/logger.dart';
import 'package:notesapp/screens/note/note_flow_coordinator.dart';
import 'package:notesapp/generated/l10n.dart';

import 'search_note_tile_event.dart';

class SearchNoteTileBloc {
  final logger = Logger();
  final StreamController<SearchNoteTileEvent> _eventController;
  final NoteFlowCoordinator _noteFlowCoordinator;

  SearchNoteTileBloc(this._eventController, this._noteFlowCoordinator) {
    _eventController.stream.listen((event) {
      _handleEvent(event);
    }).onError((error) {
      logger.e(S.current.errorRespondingToEvent, error);
    });
  }

  /// Handles a [SearchNoteTileEvent]
  _handleEvent(SearchNoteTileEvent event) {
    switch (event.runtimeType) {
      case GoToViewNoteScreenEvent:
        final viewNoteEvent = event as GoToViewNoteScreenEvent;
        _noteFlowCoordinator.goToViewNoteScreen(viewNoteEvent.id);
        break;
    }
  }
}

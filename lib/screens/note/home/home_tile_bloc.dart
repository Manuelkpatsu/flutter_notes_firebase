import 'dart:async';

import 'package:logger/logger.dart';
import 'package:notesapp/screens/note/note_flow_coordinator.dart';

import 'home_tile_event.dart';

class HomeTileBloc {
  final logger = Logger();
  final StreamController<HomeTileEvent> _eventController;
  final NoteFlowCoordinator _noteFlowCoordinator;

  HomeTileBloc(this._eventController, this._noteFlowCoordinator) {
    _eventController.stream.listen((event) {
      _handleEvent(event);
    }).onError((error) {
      logger.e('An error occurred', error);
    });
  }

  /// Handles a [HomeTileEvent]
  _handleEvent(HomeTileEvent event) {
    switch (event.runtimeType) {
      case GoToViewNoteScreenEvent:
        final viewNoteEvent = event as GoToViewNoteScreenEvent;
        _noteFlowCoordinator.goToViewNoteScreen(viewNoteEvent.id);
        break;
    }
  }
}

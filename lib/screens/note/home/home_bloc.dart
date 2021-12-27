import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:notesapp/generated/l10n.dart';
import 'package:notesapp/repository/user_repository.dart';
import 'package:notesapp/screens/note/note_flow_coordinator.dart';
import 'package:notesapp/utils/helper.dart';

import 'home_domain_model.dart';
import 'home_event.dart';
import 'home_model_data.dart';

class HomeBloc extends ValueNotifier<HomeModelData> {
  final logger = Logger();
  final BuildContext _context;
  final HomeDomainModel _homeDomainModel;
  final StreamController<HomeEvent> _eventController;
  final UserRepository _userRepository;
  final NoteFlowCoordinator _noteFlowCoordinator;

  HomeBloc(
    this._context,
    this._eventController,
    this._homeDomainModel,
    this._userRepository,
    this._noteFlowCoordinator,
  ) : super(const HomeModelData()) {
    _eventController.stream
        .listen((event) => _handleEvent(event))
        .onError((error) => logger.e('Error responding to event', error));

    _getNotes();
  }

  // Handles [HomeEvent]
  _handleEvent(HomeEvent event) {
    switch (event.runtimeType) {
      case GoToSearchScreenEvent:
        _noteFlowCoordinator.goToSearchScreen();
        break;
      case ToggleLayoutEvent:
        final toggleEvent = event as ToggleLayoutEvent;
        _toggleLayout(toggleEvent.isGrid);
        break;
      case LogoutEvent:
        _logout();
        break;
      case GoToAddNoteScreenEvent:
        _noteFlowCoordinator.goToAddNoteScreen();
        break;
    }
  }

  void _getNotes() {
    value = value.copyWith(loading: true);

    _userRepository.getCurrentUser().then((user) {
      if (user != null) {
        _homeDomainModel.getNotesStream(user.uid).listen((modelData) {
          value = modelData;
        }).onError((error) {
          logger.e('Error loading notes', error);
          value = value.copyWith(message: 'An error occurred loading notes.');
        });
      }
    }).catchError((error) {
      logger.e('Error loading authenticated user', error);
    }).whenComplete(() {
      value = value.copyWith(loading: false);
    });
  }

  void _toggleLayout(bool isGrid) {
    isGrid = !value.isGrid;
  }

  void _logout() {
    Helper.showAlertDialog(
      _context,
      S.current.wantToLogOut,
      () {
        _noteFlowCoordinator.pop();
        _userRepository.signOut().then((value) {
          Helper.showSnackbar(
            _context,
            S.current.loggedOutSuccessfully,
            Colors.green,
          );
          _noteFlowCoordinator.goToSplashScreen();
        }).catchError((error) {
          Helper.showSnackbar(
            _context,
            "Sorry, an error occurred. Please try again.",
            Colors.red,
          );
        });
      },
    );
  }

  @override
  void dispose() {
    _homeDomainModel.dispose();
    _eventController.close();
    super.dispose();
  }
}

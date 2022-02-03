import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:notesapp/generated/l10n.dart';
import 'package:notesapp/repository/user_repository.dart';
import 'package:notesapp/screens/note/note_flow_coordinator.dart';
import 'package:notesapp/utils/helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_domain_model.dart';
import 'home_event.dart';
import 'home_model_data.dart';

class HomeBloc extends ValueNotifier<HomeModelData> {
  final logger = Logger();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
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
        .onError((error) => logger.e(S.current.errorRespondingToEvent, error));

    _getNotes();
  }

  // Handles [HomeEvent]
  _handleEvent(HomeEvent event) {
    switch (event.runtimeType) {
      case GoToSearchScreenEvent:
        _noteFlowCoordinator.goToSearchScreen();
        break;
      case LogoutEvent:
        _logout();
        break;
      case GoToAddNoteScreenEvent:
        final addNoteEvent = event as GoToAddNoteScreenEvent;
        _noteFlowCoordinator.goToAddNoteScreen(addNoteEvent.arguments);
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
          logger.e(S.current.errorLoadingNotes, error);
          value = value.copyWith(message: S.current.errorLoadingNotes);
        });
      }
    }).catchError((error) {
      logger.e(S.current.errorFetchingAuthUser, error);
      value = value.copyWith(message: S.current.errorFetchingAuthUser);
    }).whenComplete(() {
      value = value.copyWith(loading: false);
    });
  }

  void _logout() {
    Helper.showAlertDialog(
      _context,
      S.current.wantToLogOut,
      () {
        _noteFlowCoordinator.pop();
        _prefs.then((SharedPreferences prefs) {
          prefs.remove('userId');
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
              S.current.tryAgain,
              Colors.red,
            );
          });
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

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:logger/logger.dart';
import 'package:notesapp/repository/user_repository.dart';
import 'package:notesapp/utils/helper.dart';

import 'search_domain_model.dart';
import 'search_event.dart';
import 'search_note_tile_model_data.dart';

class SearchBloc extends ValueNotifier<List<SearchNoteTileModelData>> {
  final _logger = Logger();
  final BuildContext _context;
  final StreamController<SearchEvent> _eventController;
  final UserRepository _userRepository;
  final SearchDomainModel _searchNoteDomainModel;
  List<SearchNoteTileModelData> _notes = [];

  SearchBloc(
    this._context,
    this._eventController,
    this._userRepository,
    this._searchNoteDomainModel,
  ) : super([]) {
    _eventController.stream
        .listen((event) => _handleEvent(event))
        .onError((error) => _logger.e('Error responding to event', error));

    _loadNotes();
  }

  /// Handles [SearchEvent]
  _handleEvent(SearchEvent event) {
    switch (event.runtimeType) {
      case SearchNoteEvent:
        final searchNoteEvent = event as SearchNoteEvent;
        _search(searchNoteEvent.searchQuery);
        break;
      case ClearSearchQueryEvent:
        _clearSearchQuery();
        break;
    }
  }

  void _loadNotes() {
    _userRepository.getCurrentUser().then((user) {
      if (user != null) {
        _searchNoteDomainModel
            .getSearchNoteTileModelDataListStream(user.uid)
            .listen((notes) {
          _notes = notes;
        }).onError((error) {
          Helper.showSnackbar(
            _context,
            "Sorry, an error occurred loading notes",
            Colors.red,
          );
          _logger.e('Error loading notes', error);
        });
      }
    }).catchError((error) {
      _logger.e('Error loading authenticated user', error);
    });
  }

  /// Searches the note list and returns
  /// notes that match the [searchQuery]
  void _search(String searchQuery) {
    final fuse = Fuzzy<SearchNoteTileModelData>(
      _notes,
      options: FuzzyOptions(
        threshold: 0.2,
        keys: [
          WeightedKey(
            getter: (i) => i.title,
            weight: 1,
            name: 'title',
          ),
        ],
      ),
    );

    final result = fuse.search(searchQuery);
    final filteredNoteList = result.map((r) => r.item).toList();
    value = filteredNoteList;
  }

  /// Resets the note list
  void _clearSearchQuery() {
    value = _notes;
  }

  @override
  void dispose() {
    _eventController.close();
    _searchNoteDomainModel.dispose();
    super.dispose();
  }
}

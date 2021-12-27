import 'package:flutter/foundation.dart';
import 'package:functional_listener/functional_listener.dart';

import 'view_note_bloc.dart';

extension ViewNoteListenable on ViewNoteBloc {
  /// Exposes a [bool].
  ///
  /// True if the progress indicator should be shown, false otherwise.
  ValueListenable<bool> get progressIndicator => map((m) => m.loading);

  /// Exposes a [String].
  ///
  /// The note's id.
  ValueListenable<String> get noteId => map((m) => m.noteId);

  /// Exposes a [String].
  ///
  /// The note's title to display.
  ValueListenable<String> get title => map((m) => m.title);

  /// Exposes a [String].
  ///
  /// The note's description to display.
  ValueListenable<String> get description => map((m) => m.description);

  /// Exposes a [String].
  ///
  /// The author's id.
  ValueListenable<String> get userId => map((m) => m.userId);

  /// Exposes a [String].
  ///
  /// The note's date to display.
  ValueListenable<String> get date => map((m) => m.date);

  /// Exposes a [int].
  ///
  /// The value for the color for displaying the note.
  ValueListenable<int> get color => map((m) => m.color);

  /// Exposes a [int].
  ///
  /// The value for the priority set for a note.
  ValueListenable<int> get priority => map((m) => m.priority);

  /// Exposes a [String].
  ///
  /// The message for displaying the error.
  ValueListenable<String> get message => map((m) => m.message);
}

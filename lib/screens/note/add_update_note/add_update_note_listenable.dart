import 'package:flutter/foundation.dart';
import 'package:functional_listener/functional_listener.dart';

import 'add_update_note_bloc.dart';

extension AddUpdateNoteListenable on AddUpdateNoteBloc {
  /// Exposes a [bool].
  ///
  /// True if the progress indicator should be shown, false otherwise.
  ValueListenable<bool> get progressIndicator => map((m) => m.saving);
}

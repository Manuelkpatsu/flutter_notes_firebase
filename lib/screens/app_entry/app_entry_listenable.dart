import 'package:flutter/foundation.dart';
import 'package:functional_listener/functional_listener.dart';

import 'app_entry_bloc.dart';

extension AppEntryListenable on AppEntryBloc {
  /// True if the user is signed in, false otherwise.
  ValueListenable<bool> get isAuthenticated => map((m) => m.isSignedIn);
}

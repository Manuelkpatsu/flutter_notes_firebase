import 'package:flutter/foundation.dart';
import 'package:functional_listener/functional_listener.dart';

import 'sign_up_bloc.dart';

extension SignUpListenable on SignUpBloc {
  /// Exposes a [bool].
  ///
  /// True if the progress indicator should be shown, false otherwise.
  ValueListenable<bool> get progressIndicator => map((m) => m.signingUp);
}

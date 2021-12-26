import 'package:flutter/foundation.dart';
import 'package:functional_listener/functional_listener.dart';

import 'login_bloc.dart';

extension SignUpListenable on LoginBloc {
  /// Exposes a [bool].
  ///
  /// True if the progress indicator should be shown, false otherwise.
  ValueListenable<bool> get progressIndicator => map((m) => m.signingIn);
}

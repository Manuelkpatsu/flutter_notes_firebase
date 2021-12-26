import 'package:flutter/foundation.dart';
import 'package:functional_listener/functional_listener.dart';

import 'forgot_password_bloc.dart';

extension ForgotPasswordListenable on ForgotPasswordBloc {
  /// Exposes a [bool].
  ///
  /// True if the progress indicator should be shown, false otherwise.
  ValueListenable<bool> get progressIndicator =>
      map((m) => m.requestingResetPasswordLink);
}

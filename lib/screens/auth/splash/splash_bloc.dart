import 'dart:async';

import '../auth_flow_coordinator.dart';

class SplashBloc {
  final AuthFlowCoordinator _authFlowCoordinator;

  SplashBloc(this._authFlowCoordinator) {
    _goToLoginScreen();
  }

  void _goToLoginScreen() {
    Future.delayed(
      const Duration(seconds: 4),
      () => _authFlowCoordinator.goToLoginScreenAndRemoveSplashScreen(),
    );
  }
}

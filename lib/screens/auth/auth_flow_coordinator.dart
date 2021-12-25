import 'package:flutter/material.dart';
import 'package:notesapp/screens/auth/login/login_screen.dart';
import 'package:notesapp/screens/auth/sign_up/sign_up_screen.dart';

import 'forgot_password/forgot_password.dart';

abstract class AuthFlowCoordinator {
  // Navigates to [LoginScreen] and remove [SplashScreen]
  void goToLoginScreenAndRemoveSplashScreen();

  // Navigates to [LoginScreen]
  void goToLoginScreen();

  // Navigates to [SignUpScreen]
  void goToSignUpScreen();

  // Navigates to [ForgotPasswordScreen]
  void goToForgotPasswordScreen();

  void goToLoginScreenAfterPasswordChange();
}

class MyAuthFlowCoordinator implements AuthFlowCoordinator {
  final BuildContext _context;

  MyAuthFlowCoordinator(this._context);

  @override
  void goToForgotPasswordScreen() {
    Navigator.pushNamed(_context, ForgotPasswordScreen.routeName);
  }

  @override
  void goToLoginScreen() {
    Navigator.pushNamed(_context, LoginScreen.routeName);
  }

  @override
  void goToLoginScreenAndRemoveSplashScreen() {
    Navigator.pushNamedAndRemoveUntil(
      _context,
      LoginScreen.routeName,
      (route) => false,
    );
  }

  @override
  void goToSignUpScreen() {
    Navigator.pushNamed(_context, SignUpScreen.routeName);
  }

  @override
  void goToLoginScreenAfterPasswordChange() {
    Navigator.pushReplacementNamed(_context, LoginScreen.routeName);
  }
}

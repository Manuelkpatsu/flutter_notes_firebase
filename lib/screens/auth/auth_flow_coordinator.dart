import 'package:flutter/material.dart';
import 'package:notesapp/screens/auth/login/login_screen.dart';
import 'package:notesapp/screens/auth/sign_up/sign_up_screen.dart';
import 'package:notesapp/screens/note/home/home_screen.dart';

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

  /// Navigates to [LoginScreen] after entering email for
  /// changing password on [ForgotPasswordScreen]
  void goToLoginScreenAfterRequestingPasswordChangeLink();

  // Navigates to [HomeScreen] after signing in or signing up
  void goToHomeScreenAfterAuthentication();
}

class MyAuthFlowCoordinator implements AuthFlowCoordinator {
  final BuildContext _context;

  MyAuthFlowCoordinator(this._context);

  @override
  void goToForgotPasswordScreen() {
    Navigator.push(
      _context,
      MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
    );
  }

  @override
  void goToLoginScreen() {
    Navigator.push(
      _context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  void goToLoginScreenAndRemoveSplashScreen() {
    Navigator.pushAndRemoveUntil(
      _context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  void goToSignUpScreen() {
    Navigator.push(
      _context,
      MaterialPageRoute(builder: (context) => const SignUpScreen()),
    );
  }

  @override
  void goToLoginScreenAfterRequestingPasswordChangeLink() {
    Navigator.pushReplacement(
      _context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  void goToHomeScreenAfterAuthentication() {
    Navigator.pushAndRemoveUntil(
      _context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
      (route) => false,
    );
  }
}

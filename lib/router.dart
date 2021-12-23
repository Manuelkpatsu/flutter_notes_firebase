import 'package:flutter/material.dart';
import 'package:notesapp/screens/auth/forgot_password/forgot_password.dart';
import 'package:notesapp/screens/auth/login/login_screen.dart';
import 'package:notesapp/screens/auth/sign_up/sign_up_screen.dart';
import 'package:notesapp/screens/home/home_screen.dart';
import 'package:notesapp/screens/note/note_screen.dart';
import 'package:notesapp/screens/search/search_screen.dart';

import 'screens/splash/splash.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.routeName:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case LoginScreen.routeName:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case SignUpScreen.routeName:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case ForgotPasswordScreen.routeName:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case SearchScreen.routeName:
        return MaterialPageRoute(builder: (_) => const SearchScreen());
      case NoteDetailScreen.routeName:
        return MaterialPageRoute(builder: (_) => const NoteDetailScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text(
                'No route defined for ${settings.name}',
              ),
            ),
          ),
        );
    }
  }
}

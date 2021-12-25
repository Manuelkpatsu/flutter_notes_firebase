import 'package:flutter/material.dart';
import 'package:notesapp/screens/add_update_note/add_update_note_screen.dart';
import 'package:notesapp/screens/add_update_note/note_arguments.dart';
import 'package:notesapp/screens/auth/forgot_password/forgot_password.dart';
import 'package:notesapp/screens/auth/login/login_screen.dart';
import 'package:notesapp/screens/auth/sign_up/sign_up_screen.dart';
import 'package:notesapp/screens/home/home_screen.dart';
import 'package:notesapp/screens/note/note_screen.dart';
import 'package:notesapp/screens/search/search_screen.dart';

import 'screens/auth/splash/splash.dart';

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
        return MaterialPageRoute(builder: (_) => NoteDetailScreen());
      case AddUpdateNoteScreen.routeName:
        final args = settings.arguments as NoteArguments?;

        return MaterialPageRoute(builder: (_) => AddUpdateNoteScreen(noteArguments: args));
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

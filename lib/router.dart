import 'package:flutter/material.dart';
import 'package:notesapp/screens/auth/forgot_password/forgot_password.dart';
import 'package:notesapp/screens/auth/login/login_screen.dart';
import 'package:notesapp/screens/auth/sign_up/sign_up_screen.dart';
import 'package:notesapp/screens/note/view_note/view_note_argument.dart';

import 'screens/auth/splash/splash.dart';
import 'screens/note/add_update_note/add_update_note_screen.dart';
import 'screens/note/add_update_note/note_arguments.dart';
import 'screens/note/home/home_screen.dart';
import 'screens/note/search/search_screen.dart';
import 'screens/note/view_note/view_note_screen.dart';

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
      case ViewNoteScreen.routeName:
        final args = settings.arguments as ViewNoteArgument;
        return MaterialPageRoute(builder: (_) => ViewNoteScreen(argument: args));
      case AddUpdateNoteScreen.routeName:
        final args = settings.arguments as NoteArguments;

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

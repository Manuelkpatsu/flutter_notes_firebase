import 'package:flutter/material.dart';
import 'package:notesapp/screens/auth/splash/splash.dart';
import 'package:notesapp/screens/note/add_update_note/add_update_note_screen.dart';
import 'package:notesapp/screens/note/view_note/view_note_argument.dart';

import 'home/home_screen.dart';
import 'search/search_screen.dart';
import 'view_note/view_note_screen.dart';

abstract class NoteFlowCoordinator {
  // Navigates to detailed note screen
  void goToViewNoteScreen(String id);

  // Navigates to search screen
  void goToSplashScreen();

  // Pop screen or widget
  void pop();

  // Navigates to search screen
  void goToSearchScreen();

  // Navigates to add note screen
  void goToAddNoteScreen();

  // Navigates to home screen after deletion
  void goToHomeScreenAfterDeletion();

  // Navigates to update note screen
  void goToUpdateNoteScreen();
}

class MyNoteFlowCoordinator implements NoteFlowCoordinator {
  final BuildContext _context;

  MyNoteFlowCoordinator(this._context);

  @override
  void goToViewNoteScreen(String id) {
    ViewNoteArgument argument = ViewNoteArgument(id);
    Navigator.push(
      _context,
      MaterialPageRoute(builder: (context) => ViewNoteScreen(argument: argument)),
    );
  }

  @override
  void goToSplashScreen() {
    Navigator.pushAndRemoveUntil(
      _context,
      MaterialPageRoute(builder: (context) => const SplashScreen()),
      (route) => false,
    );
  }

  @override
  void pop() {
    Navigator.of(_context).pop();
  }

  @override
  void goToSearchScreen() {
    Navigator.push(
      _context,
      MaterialPageRoute(builder: (context) => const SearchScreen()),
    );
  }

  @override
  void goToAddNoteScreen() {
    Navigator.push(
      _context,
      MaterialPageRoute(builder: (context) => const AddUpdateNoteScreen()),
    );
  }

  @override
  void goToHomeScreenAfterDeletion() {
    Navigator.pushReplacement(
      _context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  void goToUpdateNoteScreen() {
    Navigator.push(
      _context,
      MaterialPageRoute(builder: (context) => const AddUpdateNoteScreen()),
    );
  }
}

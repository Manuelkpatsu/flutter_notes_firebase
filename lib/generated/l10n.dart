// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null, 'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;
 
      return instance;
    });
  } 

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null, 'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Notes.`
  String get appTitle {
    return Intl.message(
      'Notes.',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `take your notes✍️`
  String get subTitle {
    return Intl.message(
      'take your notes✍️',
      name: 'subTitle',
      desc: '',
      args: [],
    );
  }

  /// `Add Note`
  String get addNote {
    return Intl.message(
      'Add Note',
      name: 'addNote',
      desc: '',
      args: [],
    );
  }

  /// `Edit Note`
  String get editNote {
    return Intl.message(
      'Edit Note',
      name: 'editNote',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get title {
    return Intl.message(
      'Title',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Note saved successfully`
  String get noteSaved {
    return Intl.message(
      'Note saved successfully',
      name: 'noteSaved',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, fields cannot be empty.`
  String get fieldsCannotBeEmpty {
    return Intl.message(
      'Sorry, fields cannot be empty.',
      name: 'fieldsCannotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to delete the note?`
  String get deleteNote {
    return Intl.message(
      'Do you want to delete the note?',
      name: 'deleteNote',
      desc: '',
      args: [],
    );
  }

  /// `Note successfully deleted`
  String get successfullyDeleted {
    return Intl.message(
      'Note successfully deleted',
      name: 'successfullyDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Low`
  String get low {
    return Intl.message(
      'Low',
      name: 'low',
      desc: '',
      args: [],
    );
  }

  /// `High`
  String get high {
    return Intl.message(
      'High',
      name: 'high',
      desc: '',
      args: [],
    );
  }

  /// `Very High`
  String get veryHigh {
    return Intl.message(
      'Very High',
      name: 'veryHigh',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred whilst loading notes.`
  String get errorLoadingNotes {
    return Intl.message(
      'An error occurred whilst loading notes.',
      name: 'errorLoadingNotes',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred whilst fetching authenticated user`
  String get errorFetchingAuthUser {
    return Intl.message(
      'An error occurred whilst fetching authenticated user',
      name: 'errorFetchingAuthUser',
      desc: '',
      args: [],
    );
  }

  /// `Search for a note by title`
  String get searchNoteByTitle {
    return Intl.message(
      'Search for a note by title',
      name: 'searchNoteByTitle',
      desc: '',
      args: [],
    );
  }

  /// `'There are no notes matching your search query.\nPlease try again.'`
  String get noNotesForSearchQuery {
    return Intl.message(
      '\'There are no notes matching your search query.\nPlease try again.\'',
      name: 'noNotesForSearchQuery',
      desc: '',
      args: [],
    );
  }

  /// `Note does not exist`
  String get noteDoesNotExist {
    return Intl.message(
      'Note does not exist',
      name: 'noteDoesNotExist',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to logout?`
  String get wantToLogOut {
    return Intl.message(
      'Do you want to logout?',
      name: 'wantToLogOut',
      desc: '',
      args: [],
    );
  }

  /// `User logged out successfully.`
  String get loggedOutSuccessfully {
    return Intl.message(
      'User logged out successfully.',
      name: 'loggedOutSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logOut {
    return Intl.message(
      'Logout',
      name: 'logOut',
      desc: '',
      args: [],
    );
  }

  /// `Register new\naccount`
  String get registerAccount {
    return Intl.message(
      'Register new\naccount',
      name: 'registerAccount',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account? `
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an account? ',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Login to your\naccount`
  String get loginToAccount {
    return Intl.message(
      'Login to your\naccount',
      name: 'loginToAccount',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account? `
  String get doNotHaveAccount {
    return Intl.message(
      'Don\'t have an account? ',
      name: 'doNotHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your\npassword`
  String get forgotYourPassword {
    return Intl.message(
      'Forgot your\npassword',
      name: 'forgotYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `The password provided is too weak.`
  String get weakPassword {
    return Intl.message(
      'The password provided is too weak.',
      name: 'weakPassword',
      desc: '',
      args: [],
    );
  }

  /// `The account already exists for that email.`
  String get emailAlreadyInUse {
    return Intl.message(
      'The account already exists for that email.',
      name: 'emailAlreadyInUse',
      desc: '',
      args: [],
    );
  }

  /// `Make sure you have a stable connection and try again`
  String get networkConnectionIssue {
    return Intl.message(
      'Make sure you have a stable connection and try again',
      name: 'networkConnectionIssue',
      desc: '',
      args: [],
    );
  }

  /// `No user found for this email`
  String get userNotFoundForEmail {
    return Intl.message(
      'No user found for this email',
      name: 'userNotFoundForEmail',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, wrong credentials provided`
  String get wrongPassword {
    return Intl.message(
      'Sorry, wrong credentials provided',
      name: 'wrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Error responding to event`
  String get errorRespondingToEvent {
    return Intl.message(
      'Error responding to event',
      name: 'errorRespondingToEvent',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred. Please try again`
  String get tryAgain {
    return Intl.message(
      'An error occurred. Please try again',
      name: 'tryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm password`
  String get pleaseConfirmPassword {
    return Intl.message(
      'Please confirm password',
      name: 'pleaseConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordsDoNotMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordsDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Email is required`
  String get emailRequired {
    return Intl.message(
      'Email is required',
      name: 'emailRequired',
      desc: '',
      args: [],
    );
  }

  /// `The email you entered is invalid`
  String get invalidEmail {
    return Intl.message(
      'The email you entered is invalid',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password is required`
  String get passwordRequired {
    return Intl.message(
      'Password is required',
      name: 'passwordRequired',
      desc: '',
      args: [],
    );
  }

  /// `Password should be more than six characters`
  String get invalidPassword {
    return Intl.message(
      'Password should be more than six characters',
      name: 'invalidPassword',
      desc: '',
      args: [],
    );
  }

  /// `Title is required`
  String get titleRequired {
    return Intl.message(
      'Title is required',
      name: 'titleRequired',
      desc: '',
      args: [],
    );
  }

  /// `Title should be more than four characters`
  String get maxTitle {
    return Intl.message(
      'Title should be more than four characters',
      name: 'maxTitle',
      desc: '',
      args: [],
    );
  }

  /// `Content is required`
  String get contentRequired {
    return Intl.message(
      'Content is required',
      name: 'contentRequired',
      desc: '',
      args: [],
    );
  }

  /// `Content should be more than nine characters`
  String get maxContent {
    return Intl.message(
      'Content should be more than nine characters',
      name: 'maxContent',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
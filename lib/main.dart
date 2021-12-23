import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:notesapp/screens/auth/forgot_password/forgot_password.dart';
import 'package:notesapp/screens/auth/login/login_screen.dart';
import 'package:notesapp/screens/auth/sign_up/sign_up_screen.dart';
import 'package:notesapp/screens/splash/splash.dart';

import 'generated/l10n.dart';
import 'locator.dart';
import 'styles.dart';
import 'router.dart';

Future<void> main() async {
  setUpLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Sans',
        textTheme: const TextTheme(
          headline5: kNoteHeadLine,
          bodyText2: kNoteBodyText2,
          bodyText1: kNoteBodyText1,
          subtitle2: kNoteSubTitle,
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          systemOverlayStyle: SystemUiOverlayStyle.light,
          elevation: 0,
        ),
      ),
      initialRoute: ForgotPasswordScreen.routeName,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}

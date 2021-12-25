import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:notesapp/generated/l10n.dart';
import 'package:notesapp/screens/home/home_screen.dart';
import 'package:notesapp/screens/splash/splash.dart';

import '../../locator.dart';
import '../../router.dart';
import '../../styles.dart';
import 'app_entry_bloc.dart';
import 'app_entry_listenable.dart';

class AppEntryScreen extends StatefulWidget {
  const AppEntryScreen({Key? key}) : super(key: key);

  @override
  _AppEntryScreenState createState() => _AppEntryScreenState();
}

class _AppEntryScreenState extends State<AppEntryScreen> {
  late final AppEntryBloc bloc;

  @override
  void initState() {
    bloc = get<AppEntryBloc>();
    super.initState();
  }

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
      home: ValueListenableBuilder<bool>(
        valueListenable: bloc.isAuthenticated,
        builder: (context, isSignedIn, child) =>
            isSignedIn ? const HomeScreen() : const SplashScreen(),
      ),
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tuple/tuple.dart';

import 'repository/note_repository.dart';
import 'repository/user_repository.dart';
import 'screens/app_entry/app_entry_bloc.dart';
import 'screens/auth/auth_flow_coordinator.dart';
import 'screens/auth/forgot_password/forgot_password_bloc.dart';
import 'screens/auth/forgot_password/forgot_password_event.dart';
import 'screens/auth/login/login_bloc.dart';
import 'screens/auth/login/login_event.dart';
import 'screens/auth/sign_up/sign_up_bloc.dart';
import 'screens/auth/sign_up/sign_up_event.dart';
import 'screens/auth/splash/splash_bloc.dart';
import 'screens/note/add_update_note/add_update_note_bloc.dart';
import 'screens/note/add_update_note/add_update_note_event.dart';
import 'screens/note/home/home_bloc.dart';
import 'screens/note/home/home_domain_model.dart';
import 'screens/note/home/home_event.dart';
import 'screens/note/home/home_tile_bloc.dart';
import 'screens/note/home/home_tile_event.dart';
import 'screens/note/note_flow_coordinator.dart';
import 'screens/note/search/search_bloc.dart';
import 'screens/note/search/search_domain_model.dart';
import 'screens/note/search/search_event.dart';
import 'screens/note/search/search_note_tile_bloc.dart';
import 'screens/note/search/search_note_tile_event.dart';
import 'screens/note/view_note/view_note_bloc.dart';
import 'screens/note/view_note/view_note_domain_model.dart';
import 'screens/note/view_note/view_note_event.dart';

final GetIt get = GetIt.instance;

void setUpLocator() {
  get.registerFactory(() => UserRepository(FirebaseAuth.instance));
  get.registerFactory(() => NoteRepository(FirebaseFirestore.instance));
  get.registerFactoryParam<MyAuthFlowCoordinator, BuildContext, void>(
    (context, _) => MyAuthFlowCoordinator(context),
  );
  get.registerFactoryParam<MyNoteFlowCoordinator, BuildContext, void>(
    (context, _) => MyNoteFlowCoordinator(context),
  );

  // AppEntryScreen
  get.registerFactoryParam<AppEntryBloc, void, void>(
    (_, empty) => AppEntryBloc(get<UserRepository>()),
  );

  // SplashScreen
  get.registerFactoryParam<SplashBloc, BuildContext, void>(
    (context, _) => SplashBloc(MyAuthFlowCoordinator(context)),
  );

  // SignUpScreen
  get.registerFactoryParam<SignUpBloc, BuildContext, StreamController<SignUpEvent>>(
    (context, eventController) => SignUpBloc(
      context,
      eventController,
      get<UserRepository>(),
      get<MyAuthFlowCoordinator>(param1: context),
    ),
  );

  // LoginScreen
  get.registerFactoryParam<LoginBloc, BuildContext, StreamController<LoginEvent>>(
    (context, eventController) => LoginBloc(
      context,
      eventController,
      get<UserRepository>(),
      get<MyAuthFlowCoordinator>(param1: context),
    ),
  );

  // ForgotPasswordScreen
  get.registerFactoryParam<ForgotPasswordBloc, BuildContext,
      StreamController<ForgotPasswordEvent>>(
    (context, eventController) => ForgotPasswordBloc(
      context,
      eventController,
      get<UserRepository>(),
      get<MyAuthFlowCoordinator>(param1: context),
    ),
  );

  // HomeScreen
  get.registerFactory(() => HomeDomainModel(get<NoteRepository>()));
  get.registerFactoryParam<HomeBloc, BuildContext, StreamController<HomeEvent>>(
    (context, eventController) => HomeBloc(
      context,
      eventController,
      get<HomeDomainModel>(),
      get<UserRepository>(),
      get<MyNoteFlowCoordinator>(param1: context),
    ),
  );
  get.registerFactoryParam<HomeTileBloc, BuildContext, StreamController<HomeTileEvent>>(
    (context, eventController) => HomeTileBloc(
      eventController,
      get<MyNoteFlowCoordinator>(param1: context),
    ),
  );

  // ViewNoteScreen
  get.registerFactory(() => ViewNoteDomainModel(get<NoteRepository>()));
  get.registerFactoryParam<ViewNoteBloc, BuildContext,
      Tuple2<StreamController<ViewNoteEvent>, String>>(
    (context, tuple) => ViewNoteBloc(
      context,
      tuple.item1,
      tuple.item2,
      get<ViewNoteDomainModel>(),
      MyNoteFlowCoordinator(context),
    ),
  );

  // AddUpdateNoteScreen
  get.registerFactoryParam<AddUpdateNoteBloc, BuildContext,
      StreamController<AddUpdateNoteEvent>>(
    (context, eventController) => AddUpdateNoteBloc(
      context,
      eventController,
      get<NoteRepository>(),
      get<MyNoteFlowCoordinator>(param1: context),
    ),
  );

  // SearchScreen
  get.registerFactory(() => SearchDomainModel(get<NoteRepository>()));
  get.registerFactoryParam<SearchBloc, BuildContext, StreamController<SearchEvent>>(
    (context, eventController) => SearchBloc(
      context,
      eventController,
      get<UserRepository>(),
      get<SearchDomainModel>(),
    ),
  );
  get.registerFactoryParam<SearchNoteTileBloc, BuildContext,
      StreamController<SearchNoteTileEvent>>(
    (context, eventController) => SearchNoteTileBloc(
      eventController,
      get<MyNoteFlowCoordinator>(param1: context),
    ),
  );
}

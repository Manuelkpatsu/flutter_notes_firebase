import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'repository/user_repository.dart';
import 'screens/app_entry/app_entry_bloc.dart';
import 'screens/auth/auth_flow_coordinator.dart';
import 'screens/auth/login/login_bloc.dart';
import 'screens/auth/login/login_event.dart';
import 'screens/auth/sign_up/sign_up_bloc.dart';
import 'screens/auth/sign_up/sign_up_event.dart';
import 'screens/auth/splash/splash_bloc.dart';

final GetIt get = GetIt.instance;

void setUpLocator() {
  get.registerFactory(() => UserRepository(FirebaseAuth.instance));
  get.registerFactoryParam<MyAuthFlowCoordinator, BuildContext, void>(
    (context, _) => MyAuthFlowCoordinator(context),
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
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import 'repository/user_repository.dart';
import 'screens/app_entry/app_entry_bloc.dart';

final GetIt get = GetIt.instance;

void setUpLocator() {
  get.registerFactory(() => UserRepository(FirebaseAuth.instance));

  /// App Entry
  get.registerFactoryParam<AppEntryBloc, void, void>(
    (_, empty) => AppEntryBloc(get<UserRepository>()),
  );
}

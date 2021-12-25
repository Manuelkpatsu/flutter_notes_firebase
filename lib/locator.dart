import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import 'repository/user_repository.dart';

final GetIt get = GetIt.instance;

void setUpLocator() {
  get.registerFactory(() => UserRepository(FirebaseAuth.instance));
}

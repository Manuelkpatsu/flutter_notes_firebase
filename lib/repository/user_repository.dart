import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepository(this._firebaseAuth);

  /// Creates a new user
  ///
  /// [email] The email for the account the user is creating
  /// [password] The password for the account the user is creating
  Future<UserCredential> registerAccount(String email, String password) {
    return _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Signs user in
  ///
  /// [email] The email for the account the user is signing into
  /// [password] The password for the account the user is signing into
  Future<UserCredential> login(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Creates a new user
  ///
  /// [email] The email used in creating the account which will be sent
  /// a link for creating a new password
  Future<void> resetPassword(String email) {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  // Signs the active user out
  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }

  // Gets the current user
  Future<User?> getCurrentUser() {
    return Future.value(_firebaseAuth.currentUser);
  }

  // Checks if the current user is signed in
  Future<bool> isSignedIn() {
    return Future.value(_firebaseAuth.currentUser != null);
  }
}

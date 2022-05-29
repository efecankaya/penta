import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  static Future loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      var user = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return user != null;
    } catch (e) {
      return null;
    }
  }

  static Future signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      var authResult = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return authResult.user != null;
    } catch (e) {
      return null;
    }
  }
}

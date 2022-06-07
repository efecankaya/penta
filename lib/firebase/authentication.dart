import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:penta/routes/create_profile_view.dart';

class Authentication {
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  static Future<String> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "success";
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  static Future<String> signUpWithEmail({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "success";
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }
}
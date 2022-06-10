import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:penta/routes/create_profile_view.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'dart:typed_data';
import 'package:penta/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Authentication {
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get user details
  Future<Profile> getUserDetails() async {
    User currentUser = firebaseAuth.currentUser!;

    DocumentSnapshot documentSnapshot =
    await _firestore.collection('users').doc(currentUser.uid).get();

    return Profile.fromSnap(documentSnapshot);
  }

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
    required String name,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    try {
      //register user
      UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      //add user to the db
      String photoUrl = await uploadImageToStorage('profilePics', file, false);

      Profile _user = Profile(
        name: name,
        username: username,
        uid: cred.user!.uid,
        photoUrl: photoUrl,
        email: email,
        bio: bio,
        followers: [],
        following: [],
      );

      // adding user in our database
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection("Users").doc(cred.user!.uid).set(_user.toJson());

      return "success";
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  static Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  // adding image to firebase storage
  static Future<String> uploadImageToStorage(String childName, Uint8List file, bool isPost) async {
    // creating location to our firebase storage
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child(childName).child(firebaseAuth.currentUser!.uid);
    if(isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }

    // putting in uint8list format -> Upload task like a future but not future
    UploadTask uploadTask = ref.putData(
        file
    );

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
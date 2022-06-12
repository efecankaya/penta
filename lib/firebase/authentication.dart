
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'dart:typed_data';
import 'package:penta/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Authentication {
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // get user details
  static Future<Profile> getCurrentUserDetails() async {
    User currentUser = firebaseAuth.currentUser!;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentSnapshot documentSnapshot =
    await firestore.collection('Users').doc(currentUser.uid).get();

    return Profile.fromSnap(documentSnapshot);
  }

  static Future<Profile> getUserDetails(String uid) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentSnapshot documentSnapshot = await firestore.collection('Users').doc(
        uid).get();

    return Profile.fromSnap(documentSnapshot);
  }

  static Future<String> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "success";
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  static Future<String> writeUserInfo(
      {required Profile user, required UserCredential cred}) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore
          .collection("Users")
          .doc(cred.user!.uid)
          .set(user.toJson());
      return "success";
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  static Future<UserCredential?> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      //register user
      UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return cred;
    } on FirebaseAuthException catch (e) {
      return null;
    }
  }

  static Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  // adding image to firebase storage
  static Future<String> uploadImageToStorage(String childName, Uint8List file,
      bool isPost) async {
    // creating location to our firebase storage
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref =
    storage.ref().child(childName).child(firebaseAuth.currentUser!.uid);
    if (isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }

    // putting in uint8list format -> Upload task like a future but not future
    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

}

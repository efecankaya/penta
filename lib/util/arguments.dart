import 'package:penta/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RootArguments {
  bool? loggedIn;
  bool? initialLoad;

  RootArguments({this.loggedIn, this.initialLoad});
}

class ProfileArguments {
  UserCredential cred;
  String username;
  String email;

  ProfileArguments(this.cred, this.username, this.email);
}
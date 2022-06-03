import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  var _googleSignIn= GoogleSignIn();
  var googleAccount= Rx<GoogleSignInAccount?>(null);
  Future<GoogleSignInAccount?> login() async {
    googleAccount.value = await _googleSignIn.signIn();
      return googleAccount.value;
  }

  logout() async {
    googleAccount.value = await _googleSignIn.signOut();
  }
}
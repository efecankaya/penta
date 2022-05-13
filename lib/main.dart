import 'package:flutter/material.dart';
import 'package:penta/routes/login_view.dart';
import 'package:penta/routes/signup_view.dart';
import 'package:penta/routes/welcome_view.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      '/': (context) => const Welcome(),
      SignUp.routeName: (context) => SignUp(),
      Login.routeName: (context) => Login(),
    },
  ));
}
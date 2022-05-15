import 'package:flutter/material.dart';
import 'package:penta/routes/login_view.dart';
import 'package:penta/routes/signup_view.dart';
import 'package:penta/routes/welcome_view.dart';
import 'package:penta/routes/feed_view.dart';
import 'package:penta/routes/post_view.dart';
import 'package:penta/util/colors.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      '/': (context) => const WelcomeView(),
      SignUpView.routeName: (context) => SignUpView(),
      LoginView.routeName: (context) => LoginView(),
      FeedView.routeName: (context) => FeedView(),
      PostView.routeName: (context) => PostView(),
    },
    theme: ThemeData(
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: AppColors.quaternary,
        secondary: AppColors.primary,
      ),
    ),
  ));
}
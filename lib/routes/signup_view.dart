import 'package:flutter/material.dart';
import 'package:penta/util/colors.dart';
import 'package:penta/util/styles.dart';
import 'package:penta/util/screenSizes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:email_validator/email_validator.dart';
import 'package:penta/util/arguments.dart';
import 'package:penta/firebase/analytics.dart';
import 'package:penta/firebase/authentication.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();

  static const String routeName = '/signup';
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  String username = "";
  String email = "";
  String password = "";

  Future<void> _showDialog(String title, String message) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(message),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = screenSize(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign Up',
          style: kAppBarTitleTextStyle,
        ),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        width: double.infinity,
        height: screenHeight(context),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Image.asset(
                  'assets/icons/penta-transparent.png',
                  width: 250,
                ),
                const SizedBox(height: 50),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      width: screenWidth(context, dividedBy: 1.25),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(29),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "Username",
                          icon: Icon(
                            Icons.person,
                            color: AppColors.primary,
                          ),
                          hintStyle: TextStyle(color: AppColors.primary),
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value != null) {
                            if (value.isEmpty) {
                              return 'Cannot leave username empty';
                            }
                            if (value.length < 6) {
                              return 'Username too short';
                            }
                          }
                        },
                        onSaved: (value) {
                          username = value ?? '';
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      width: screenWidth(context, dividedBy: 1.25),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(29),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Your Email",
                          icon: Icon(
                            Icons.email,
                            color: AppColors.primary,
                          ),
                          hintStyle: TextStyle(color: AppColors.primary),
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value != null) {
                            if (value.isEmpty) {
                              return 'Cannot leave e-mail empty';
                            }
                            if (!EmailValidator.validate(value)) {
                              return 'Please enter a valid e-mail address';
                            }
                          }
                        },
                        onSaved: (value) {
                          email = value ?? '';
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      width: screenWidth(context, dividedBy: 1.25),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(29),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          hintText: "Password",
                          icon: Icon(
                            Icons.lock,
                            color: AppColors.primary,
                          ),
                          hintStyle: TextStyle(color: AppColors.primary),
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value != null) {
                            if (value.isEmpty) {
                              return 'Cannot leave password empty';
                            }
                            if (value.length < 6) {
                              return 'Password too short';
                            }
                          }
                        },
                        onSaved: (value) {
                          password = value ?? '';
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: screenWidth(context, dividedBy: 1.25),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(29),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: AppColors.primary,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              "Sign Up",
                              style: kButtonDarkTextStyle,
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              String result =
                                  await Authentication.signUpWithEmail(
                                      email: email, password: password);
                              if (result == 'weak-password') {
                                _showDialog("Signup Error", 'The password provided is too weak.');
                              } else if (result == 'email-already-in-use') {
                                _showDialog("Signup Error", 'An account already exists for this email.');
                              } else if (result == "success") {
                                final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                                prefs.setBool("loggedIn", true);
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  "/",
                                      (r) => false,
                                  arguments:
                                  RootArguments(initialLoad: false),
                                );
                              } else {
                                _showDialog("Signup Error", 'An unknown error has occurred.');
                              }
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

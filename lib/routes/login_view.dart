import 'package:flutter/material.dart';
import 'package:penta/util/colors.dart';
import 'package:penta/util/styles.dart';
import 'package:penta/util/screenSizes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:email_validator/email_validator.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();

  static const String routeName = '/login';
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";

  /*
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
  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: kAppBarTitleTextStyle,
        ),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Image.asset(
                'assets/icons/penta-transparent.png',
                width: 250,
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: "Your Email",
                            icon: Icon(
                              Icons.email,
                              color: AppColors.primary,
                            ),
                            hintStyle: kHintLabelStyle,
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
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: InputDecoration(
                            hintText: "Password",
                            icon: Icon(
                              Icons.lock,
                              color: AppColors.primary,
                            ),
                            hintStyle: kHintLabelStyle,
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
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                                "Login",
                                style: kButtonDarkTextStyle,
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setBool("loggedIn", true);
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  "/",
                                  (r) => false,
                                );
                              } else {
                                //_showDialog('Error', 'Please input a valid email');
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
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:penta/routes/login_view.dart';
import 'package:penta/routes/signup_view.dart';
import 'package:penta/util/colors.dart';
import 'package:penta/util/dimensions.dart';
import 'package:penta/util/styles.dart';
import 'package:penta/firebase/analytics.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        maintainBottomViewPadding: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Image.asset(
                'assets/icons/penta-transparent.png',
                width: 250,
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: Dimen.regularPadding,
                child: RichText(
                  text: TextSpan(
                    text: "Welcome.\n",
                    style: kHeadingTextStyle,
                    children: const <TextSpan>[
                      TextSpan(
                        text: "Get started by logging\ninto your account.",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 20.0),
                child: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: OutlinedButton.icon(
                            icon: Image.asset(
                              "assets/icons/icons8-facebook-240.png",
                              width: 23,
                              height: 23,
                            ),
                            onPressed: () {
                              //Facebook signup
                            },
                            label: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              child: Text(
                                'Facebook',
                                style: kButtonDarkTextStyle,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: AppColors.secondary,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          flex: 1,
                          child: OutlinedButton.icon(
                            icon: Image.asset(
                              "assets/icons/icons8-google-240.png",
                              width: 23,
                              height: 23,
                            ),
                            onPressed: () {
                              //Google signup
                            },
                            label: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              child: Text(
                                'Gmail',
                                style: kButtonDarkTextStyle,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: AppColors.secondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Analytics.logCustomEvent(
                                "signup_view",
                                null,
                              );
                              Navigator.pushNamed(
                                  context, SignUpView.routeName);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              child: Text(
                                'Sign up with email',
                                style: kButtonLightTextStyle,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                            ),
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
                        GestureDetector(
                          onTap: () {
                            Analytics.logCustomEvent(
                              "login_view",
                              null,
                            );
                            Navigator.pushNamed(context, LoginView.routeName);
                          },
                          child: RichText(
                            text: TextSpan(
                              text: "Existing user?  ",
                              style: kLabelStyle,
                              children: const <TextSpan>[
                                TextSpan(
                                  text: "Login now",
                                  style: TextStyle(
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:penta/routes/feed_view.dart';
import 'package:penta/util/colors.dart';
import 'package:penta/util/styles.dart';
import 'package:penta/util/screenSizes.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();

  static const String routeName = '/signup';
}

class _SignUpViewState extends State<SignUpView> {
  @override
  Widget build(BuildContext context) {
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
      body: Column(
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      width: screenWidth(context, dividedBy: 1.25),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(29),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Username",
                          icon: Icon(
                            Icons.person,
                            color: AppColors.primary,
                          ),
                          hintStyle: TextStyle(color: AppColors.primary),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      width: screenWidth(context, dividedBy: 1.25),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(29),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Your Email",
                          icon: Icon(
                            Icons.email,
                            color: AppColors.primary,
                          ),
                          hintStyle: TextStyle(color: AppColors.primary),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      width: screenWidth(context, dividedBy: 1.25),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(29),
                      ),
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
                          icon: Icon(
                            Icons.lock,
                            color: AppColors.primary,
                          ),
                          hintStyle: TextStyle(color: AppColors.primary),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
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
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              "Sign Up",
                              style: kButtonDarkTextStyle,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              "/",
                              (r) => false,
                              arguments: true,
                            );
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
    );
  }
}

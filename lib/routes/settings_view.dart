import 'package:flutter/material.dart';
import 'package:penta/util/colors.dart';
import 'package:penta/util/styles.dart';
import 'package:penta/model/user.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
  static const String routeName = '/profile/settings';
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: kAppBarTitleTextStyle,
        ),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            Row(
              children: [
                Icon(
                  Icons.lock,
                  color: AppColors.tertiary,
                  size: 30,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Privacy",
                  style: kLargeLabelStyle,
                ),
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Private Profile",
                  style: kLabelStyle,
                ),
                Switch(
                  activeColor: AppColors.primary,
                  value: true,
                  onChanged: (bool val) {

                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Hide Activity Status",
                  style: kLabelStyle,
                ),
                Switch(
                  activeColor: AppColors.primary,
                  value: true,
                  onChanged: (bool val) {

                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Hide Connections",
                  style: kLabelStyle,
                ),
                Switch(
                  activeColor: AppColors.primary,
                  value: true,
                  onChanged: (bool val) {

                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Hide Subscriptions",
                  style: kLabelStyle,
                ),
                Switch(
                  activeColor: AppColors.primary,
                  value: true,
                  onChanged: (bool val) {

                  },
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: AppColors.tertiary,
                  size: 30,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Account",
                  style: kLargeLabelStyle,
                ),
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Change Username",
                  style: kLabelStyle,
                ),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Change Password",
                  style: kLabelStyle,
                ),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Deactivate Account",
                  style: kLabelStyle,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Delete Account",
                  style: kLabelStyle,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Icon(
                  Icons.notifications,
                  color: AppColors.tertiary,
                  size: 30,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Notifications",
                  style: kLargeLabelStyle,
                ),
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Pause All",
                  style: kLabelStyle,
                ),
                Switch(
                  activeColor: AppColors.primary,
                  value: true,
                  onChanged: (bool val) {

                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

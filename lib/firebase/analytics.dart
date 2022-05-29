import 'package:firebase_analytics/firebase_analytics.dart';

class Analytics{
  static final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  static Future<void> setUserId(String userID) async {
    await analytics.setUserId(id: userID);
  }

  static Future<void> setScreenName(String screenName) async {
    await analytics.setCurrentScreen(screenName: screenName);
  }

  static Future<void> logCustomEvent(String logName, Map<String, dynamic> map) async {
    await analytics.logEvent(name: logName, parameters: map);
  }

  static Future<void> logLogin() async {
    await analytics.logLogin(loginMethod: 'email');
  }

  static Future<void> logSignUp() async {
    await analytics.logSignUp(signUpMethod: 'email');
  }

  static Future<void> logPostCreated() async {
    await analytics.logEvent(
      name: 'create_post',
    );
  }
}

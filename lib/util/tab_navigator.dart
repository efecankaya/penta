import 'package:flutter/material.dart';
import 'package:penta/routes/feed_view.dart';
import 'package:penta/routes/search_view.dart';
import 'package:penta/routes/upload_view.dart';
import 'package:penta/routes/messages_view.dart';
import 'package:penta/routes/profile_view.dart';

class TabNavigator extends StatelessWidget {
  final String tabItem;

  const TabNavigator({Key? key, required this.tabItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child;

    if (tabItem == "feed") {
      child = const FeedView();
    } else if (tabItem == "search") {
      child = SearchView();
    } else if (tabItem == "upload") {
      child = const UploadView();
    } else if (tabItem == "messages") {
      child = const MessagesView();
    } else {
      child = const ProfileView(userId: 0);
    }
    return child;
  }
}

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

    if (tabItem == "feed_view") {
      child = const FeedView();
    } else if (tabItem == "search_view") {
      child = SearchView();
    } else if (tabItem == "upload_view") {
      child = const UploadView();
    } else if (tabItem == "messages_view") {
      child = MessagesView();
    } else {
      child = const ProfileView(userId: 0);
    }
    return child;
  }
}

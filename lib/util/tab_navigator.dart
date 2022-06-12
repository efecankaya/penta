import 'package:flutter/material.dart';
import 'package:penta/routes/feed_view.dart';
import 'package:penta/routes/search_view.dart';
import 'package:penta/routes/upload_view.dart';
import 'package:penta/routes/messages_view.dart';
import 'package:penta/routes/profile_view.dart';
import 'package:penta/model/user.dart';
import 'package:penta/firebase/authentication.dart';

class TabNavigator extends StatefulWidget {
  final String tabItem;
  Profile? currentUser;

  TabNavigator({Key? key, required this.tabItem, this.currentUser}) : super(key: key);

  @override
  State<TabNavigator> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  @override
  Widget build(BuildContext context) {
    Widget child;

    if (widget.tabItem == "feed_view") {
      child = const FeedView();
    } else if (widget.tabItem == "search_view") {
      child = SearchView();
    } else if (widget.tabItem == "upload_view") {
      child = const UploadView();
    } else if (widget.tabItem == "messages_view") {
      child = MessagesView();
    } else {
      child = widget.currentUser == null
          ? Container(
          alignment: FractionalOffset.center,
          child: CircularProgressIndicator())
          : ProfileView(uid: widget.currentUser!.uid);
    }
    return child;
  }
}


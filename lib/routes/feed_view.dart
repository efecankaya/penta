import 'package:flutter/material.dart';
import 'package:penta/util/styles.dart';
import 'package:penta/util/colors.dart';
import 'package:penta/ui/staggered_grid_posts.dart';
import 'package:penta/model/post.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class FeedView extends StatefulWidget {
  const FeedView({Key? key}) : super(key: key);

  @override
  State<FeedView> createState() => _FeedViewState();
  static const String routeName = '/feed';
}

class _FeedViewState extends State<FeedView> {
  List<Post>? feedData;

  @override
  void initState() {
    super.initState();
    this._loadFeed();
  }

  Future<Null> _refresh() async {
    await _getFeed();
    setState(() {});
    return;
  }

  buildFeed() {
    if (feedData != null) {
      return SingleChildScrollView(child: StaggeredGridPosts(posts: feedData!));
    } else {
      return Container(
          alignment: FractionalOffset.center,
          child: CircularProgressIndicator());
    }
  }

  _loadFeed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? json = prefs.getString("feed");

    if (json != null) {
      List<Map<String, dynamic>> data =
          jsonDecode(json).cast<Map<String, dynamic>>();
      List<Post> listOfPosts = _generateFeed(data);
      setState(() {
        feedData = listOfPosts;
      });
    } else {
      _getFeed();
    }
  }

  _getFeed() async {
    QuerySnapshot posts = await FirebaseFirestore.instance.collection("Posts").get();
    List<Post> postList = posts.docs.map((doc) => Post.fromMap(doc.data() as Map<String,dynamic>)).toList();
    setState(() {
      feedData = postList;
    });
  }

  List<Post> _generateFeed(List<Map<String, dynamic>> feedData) {
    List<Post> listOfPosts = [];

    for (var postData in feedData) {
      listOfPosts.add(Post.fromJSON(postData));
    }

    return listOfPosts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Feed',
          style: kAppBarTitleTextStyle,
        ),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: buildFeed(),
      ),
    );
  }
}

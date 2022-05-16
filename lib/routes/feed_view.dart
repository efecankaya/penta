import 'package:flutter/material.dart';
import 'package:penta/util/styles.dart';
import 'package:penta/util/colors.dart';
import 'package:penta/ui/staggered_grid_posts.dart';

class FeedView extends StatefulWidget {
  const FeedView({Key? key}) : super(key: key);

  @override
  State<FeedView> createState() => _FeedViewState();
  static const String routeName = '/feed';
}

class _FeedViewState extends State<FeedView> {
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
      body: StaggeredGridPosts(0),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:penta/util/colors.dart';
import 'package:penta/util/dimensions.dart';
import 'package:penta/util/styles.dart';
import 'package:penta/routes/post_view.dart';
import 'package:penta/model/dummy_data.dart';
import 'package:penta/model/post.dart';

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
      body: SingleChildScrollView(
        child: StaggeredGrid.count(
          crossAxisCount: 2,
          children: List.generate(
            12,
            (int i) {
              return _Tile(i);
            },
          ),
        ),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  _Tile(this.i);

  final int i;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              PostView.routeName,
              arguments: PostArguments(DUMMY_POSTS[i]),
            );
          },
          child: Hero(
            child: Image.asset("assets/images/$i.jpeg"),
            tag: "$i",
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:penta/util/colors.dart';
import 'package:penta/util/dimensions.dart';
import 'package:penta/util/styles.dart';
import 'package:penta/routes/post_view.dart';
import 'package:penta/model/dummy_data.dart';
import 'package:penta/model/post.dart';

class StaggeredGridPosts extends StatefulWidget {
  final int screenId;
  String? username;

  StaggeredGridPosts(this.screenId);

  StaggeredGridPosts.user(this.screenId, this.username);

  @override
  State<StaggeredGridPosts> createState() => _StaggeredGridPostsState();
}

class _StaggeredGridPostsState extends State<StaggeredGridPosts> {
  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.count(
      crossAxisCount: 2,
      axisDirection: AxisDirection.down,
      children: List.generate(
        13,
            (int i) {
          if(widget.username == null) {
            return _Tile(i, widget.screenId);
          }
          else {
            if(DUMMY_POSTS[i].username == widget.username) {
              return _Tile(i, widget.screenId);
            }
            else {
              return SizedBox.shrink();
            }
          }
        },
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  _Tile(this.i, this.screenId);

  final int i;
  final int screenId;

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
              arguments: PostArguments(DUMMY_POSTS[i], screenId),
            );
          },
          child: Hero(
            child: Image.asset("assets/images/$i.jpeg"),
            tag: "$screenId-assets/images/$i.jpeg",
          ),
        ),
      ),
    );
  }
}

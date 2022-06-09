import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:penta/routes/post_view.dart';
import 'package:penta/model/post.dart';
import 'package:penta/firebase/analytics.dart';

//This currently only works for a fixed number of posts that are indexed.
//Subject to change when we add Firebase to the project.
class StaggeredGridPosts extends StatefulWidget {
  final List<Post> posts;

  StaggeredGridPosts({required this.posts});

  @override
  State<StaggeredGridPosts> createState() => _StaggeredGridPostsState();
}

class _StaggeredGridPostsState extends State<StaggeredGridPosts> {
  @override
  Widget build(BuildContext context) {
    if (widget.posts != null) {
      List<Post> posts = widget.posts;
      return StaggeredGrid.count(
        crossAxisCount: 2,
        axisDirection: AxisDirection.down,
        children: List.generate(
          posts.length,
          (int i) {
            //For each element, do the following:
            return _Tile(posts[i]);
          },
        ),
      );
    } else {
      return Text("loading..");
    }
  }
}

//Tile contains the post. When clicked, it sends us to that post's PostView.
class _Tile extends StatelessWidget {
  _Tile(this.post);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              PostView.routeName,
              arguments: post,
            );
          },
          child: Image.network(post.mediaUrl),
        ),
      ),
    );
  }
}

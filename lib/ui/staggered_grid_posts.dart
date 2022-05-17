import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:penta/routes/post_view.dart';
import 'package:penta/model/dummy_data.dart';

//This currently only works for a fixed number of posts that are indexed.
//Subject to change when we add Firebase to the project.
class StaggeredGridPosts extends StatefulWidget {
  //Used to filter posts
  final String? username;

  //Username will be used to filter out any post that is not from that user.
  //If we want to display every post, username will be null.
  StaggeredGridPosts({this.username = null});

  @override
  State<StaggeredGridPosts> createState() => _StaggeredGridPostsState();
}

class _StaggeredGridPostsState extends State<StaggeredGridPosts> {
  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.count(
      crossAxisCount: 2,
      axisDirection: AxisDirection.down,

      //Creates staggered grid view with 13 elements.
      children: List.generate(
        13,
        (int i) {
          //For each element, do the following:
          if (widget.username == null) {
            return _Tile(i);
          } else {
            if (DUMMY_POSTS[i].username == widget.username) {
              return _Tile(i);
            } else {
              return const SizedBox.shrink(); //Return an empty widget
            }
          }
        },
      ),
    );
  }
}

//Tile contains the post. When clicked, it sends us to that post's PostView.
class _Tile extends StatelessWidget {
  const _Tile(this.i);

  final int i;

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
              arguments: DUMMY_POSTS[i],
            );
          },
          child: Image.asset("assets/images/$i.jpeg"),
        ),
      ),
    );
  }
}

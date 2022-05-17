import 'package:flutter/material.dart';
import 'package:penta/util/colors.dart';
import 'package:penta/util/styles.dart';
import 'package:penta/util/screenSizes.dart';
import 'package:penta/model/post.dart';
import 'package:penta/model/comment.dart';
import 'package:penta/routes/profile_view.dart';
import 'package:penta/model/dummy_data.dart';
import 'package:penta/model/user.dart';

class PostView extends StatefulWidget {
  @override
  _PostViewState createState() => _PostViewState();

  static const String routeName = '/post';

  //This contains the post data.
  final Post currentPost;

  const PostView(this.currentPost);
}

class _PostViewState extends State<PostView> {
  @override
  Widget build(BuildContext context) {
    final currentPost = widget.currentPost;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          currentPost.image,
          style: kAppBarTitleTextStyle,
        ),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  GestureDetector(
                    child: CircleAvatar(
                      backgroundColor: AppColors.primary,
                      child: Image.network(
                        "https://icon-library.com/images/profile-icon/profile-icon-22.jpg",
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    //Find user based on username, push that user's profile to the navigation stack.
                    //Find method subject to change.
                    onTap: () {
                      User currentUser = DUMMY_USERS
                          .where((element) =>
                              element.username == currentPost.username)
                          .toList()[0];
                      Navigator.pushNamed(context, ProfileView.routeName,
                          arguments: currentUser.id);
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentPost.username,
                        style: kBoldLabelStyle,
                      ),
                      Text(
                        currentPost.location,
                        style: kSmallLabelStyle,
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(Icons.more_horiz),
                ],
              ),
            ),
            Image.asset(
              currentPost.image,
              fit: BoxFit.cover,
              width: screenWidth(context),
              alignment: Alignment.center,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  const Icon(
                    Icons.favorite_border,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "${currentPost.likes} likes",
                    style: kLabelStyle,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  //TODO: implement share functionality
                  const Icon(
                    Icons.share_outlined,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Share",
                    style: kLabelStyle,
                  ),
                  const Spacer(),
                  //TODO: format date. example: 2 days ago.
                  Text(
                    currentPost.date,
                    style: kLabelStyle,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: RichText(
                text: TextSpan(
                  style: kLabelStyle,
                  children: <TextSpan>[
                    TextSpan(
                      text: currentPost.username + "  ",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: currentPost.description,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: getTopics(currentPost.topics),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.quaternary,
                    child: Image.network(
                      "https://icon-library.com/images/profile-icon/profile-icon-22.jpg",
                      fit: BoxFit.fitHeight,
                    ),
                    radius: 15,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Add a comment...',
                        isDense: true,
                        contentPadding:
                            const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      ),
                      style: kLabelStyle,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Text(
                "View all comments...",
                style: kFadedLabelStyle,
              ),
            ),
            getComments(currentPost.comments),
            const SizedBox(
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}

//TODO: implement tap function for topics.
Widget getTopics(List<String> strings) {
  var list = <Widget>[];
  for (var i = 0; i < strings.length; i++) {
    list.add(Text(
      "#" + strings[i] + "  ",
      style: kTopicsLabelStyle,
    ));
  }
  return Row(children: list);
}

//Returns every comment as a Column widget
Widget getComments(List<Comment> comments) {
  var list = <Widget>[];
  for (var i = 0; i < comments.length; i++) {
    list.add(
      Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            child: RichText(
              text: TextSpan(
                style: kLabelStyle,
                children: <TextSpan>[
                  TextSpan(
                    text: "${comments[i].username}  ",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: comments[i].text,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  return Column(children: list);
}

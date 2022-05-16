import 'package:flutter/material.dart';
import 'package:penta/util/colors.dart';
import 'package:penta/util/styles.dart';
import 'package:penta/util/screenSizes.dart';
import 'package:penta/model/post.dart';
import 'package:penta/model/comment.dart';

class PostView extends StatefulWidget {
  @override
  _PostViewState createState() => _PostViewState();

  static const String routeName = '/post';
}

class _PostViewState extends State<PostView> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as PostArguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          args.post.image,
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
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.primary,
                    child: Image.network(
                      "https://icon-library.com/images/profile-icon/profile-icon-22.jpg",
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        args.post.username,
                        style: kBoldLabelStyle,
                      ),
                      Text(
                        args.post.location,
                        style: kSmallLabelStyle,
                      ),
                    ],
                  ),
                  Spacer(),
                  Icon(Icons.more_horiz),
                ],
              ),
            ),
            Hero(
              tag: "${args.screenId}-${args.post.image}",
              child: Image.asset(
                args.post.image,
                fit: BoxFit.cover,
                width: screenWidth(context),
                alignment: Alignment.center,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 30,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "${args.post.likes} likes",
                    style: kLabelStyle,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Icon(
                    Icons.share_outlined,
                    size: 30,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Share",
                    style: kLabelStyle,
                  ),
                  Spacer(),
                  Text(
                    args.post.date,
                    style: kLabelStyle,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: RichText(
                text: TextSpan(
                  style: kLabelStyle,
                  children: <TextSpan>[
                    TextSpan(
                      text: args.post.username + "  ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: args.post.description,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: getTopics(args.post.topics),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Add a comment...',
                        isDense: true,
                        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      ),
                      style: kLabelStyle,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Text(
                "View all comments...",
                style: kFadedLabelStyle,
              ),
            ),
            getComments(args.post.comments),
            SizedBox(
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}

class PostArguments {
  final Post post;
  final int screenId;

  PostArguments(this.post, this.screenId);
}

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

Widget getComments(List<Comment> comments) {
  var list = <Widget>[];
  for (var i = 0; i < comments.length; i++) {
    list.add(
      Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            child: RichText(
              text: TextSpan(
                style: kLabelStyle,
                children: <TextSpan>[
                  TextSpan(
                    text: "${comments[i].username}  ",
                    style: TextStyle(
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

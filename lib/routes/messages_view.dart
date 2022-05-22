import 'package:flutter/material.dart';
import 'package:penta/model/notif.dart';
import 'package:penta/util/colors.dart';
import 'package:penta/util/styles.dart';

import 'package:penta/routes/profile_view.dart';
import 'package:penta/model/dummy_data.dart';
import 'package:penta/model/user.dart';
import 'package:penta/routes/post_view.dart';

class MessagesView extends StatelessWidget {
  const MessagesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Activity",
          style: kAppBarTitleTextStyle,
        ),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ActivityBuilder(context, DUMMY_NOTIF),
      ),
    );
  }
}

Widget ActivityBuilder(context, List<Notif> DUMMY_NOTIF) {
  var list = <Widget>[];
  for (var i = 0; i < DUMMY_NOTIF.length; i++) {
    list.add(
      Column(
        children: [
          Row(
            children: [
              GestureDetector(
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.primary,
                  child: Image.network(
                    "https://icon-library.com/images/profile-icon/profile-icon-22.jpg",
                    fit: BoxFit.fitHeight,
                  ),
                ),
                onTap: () {
                  User currentUser = DUMMY_USERS
                      .where((element) =>
                          element.username == "${DUMMY_NOTIF[i].username}")
                      .toList()[0];
                  Navigator.pushNamed(context, ProfileView.routeName,
                      arguments: currentUser.id);
                },
              ),
              GestureDetector(
                  child: RichText(
                    text: TextSpan(
                      style: kLabelStyle,
                      children: <TextSpan>[
                        TextSpan(
                          text: "      ${DUMMY_NOTIF[i].username}:  ",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: DUMMY_NOTIF[i].text,
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    if (DUMMY_NOTIF[i].commentincl == true) {
                      Navigator.pushNamed(
                        context,
                        PostView.routeName,
                        arguments: DUMMY_POSTS[DUMMY_NOTIF[i].postId],
                      );
                    }
                  }),
              const Spacer(),
              DUMMY_NOTIF[i].text == "following you"
              ? ElevatedButton(
                onPressed: () {

                },
                child: Text(
                  "Follow",
                  style: kSmallButtonDarkTextStyle,
                ),
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(100, 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ):SizedBox.shrink(),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
  return Column(children: list);
}

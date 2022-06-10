import 'package:flutter/material.dart';
import 'package:penta/model/notif.dart';
import 'package:penta/util/colors.dart';
import 'package:penta/util/screenSizes.dart';
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
    Profile currentUser = DUMMY_USERS[0];
    list.add(
      Column(
        children: [
          Row(
            children: [
              GestureDetector(
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.primary,
                  backgroundImage: NetworkImage(
                    currentUser.photoUrl,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, ProfileView.routeName,
                      arguments: currentUser.uid);
                },
              ),
              GestureDetector(
                  child: RichText(
                    text: TextSpan(
                      style: kLabelStyle,
                      children: <TextSpan>[
                        TextSpan(
                          text: "   ${DUMMY_NOTIF[i].username}:  ",
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
                    /*
                    if (DUMMY_NOTIF[i].commentincl == true) {
                      Navigator.pushNamed(
                        context,
                        PostView.routeName,
                        arguments: DUMMY_POSTS[DUMMY_NOTIF[i].postId],
                      );
                    }

                     */
                  }),
              const Spacer(),
              DUMMY_NOTIF[i].text == "is following you"
                  ? ElevatedButton(
                      onPressed: () {},
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
                    )
                  : SizedBox.shrink(),

              DUMMY_NOTIF[i].text.contains('post') || DUMMY_NOTIF[i].text.contains('photo')
                  ? GestureDetector(
                      child:Container(
                        child: Image.network(
                          "https://ystyangin.com/wp-content/uploads/dummy-image-square.jpg",
                          scale: 4.7,
                        ),
                        height: 60,
                        width: 60,
                      ),
                      onTap: () {
                        /*
                        if (DUMMY_NOTIF[i].commentincl == true) {
                          Navigator.pushNamed(
                            context,
                            PostView.routeName,
                            arguments: DUMMY_POSTS[DUMMY_NOTIF[i].postId],
                          );
                        }
                         */
                      }
                    )
                  : SizedBox.shrink(),
                  
            ],
          ),
          Divider(
            color: Colors.grey.shade300,
            height: 20,
            thickness: 1.3,
            indent: 5,
            endIndent: 5,
          ),
        ],
      ),
    );
  }
  return Column(children: list);
}

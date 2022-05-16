import 'package:flutter/material.dart';
import 'package:penta/util/colors.dart';
import 'package:penta/util/styles.dart';
import 'package:penta/model/user.dart';
import 'package:penta/model/dummy_data.dart';
import 'package:penta/ui/staggered_grid_posts.dart';

class ProfileView extends StatefulWidget {
  final int userId;

  const ProfileView({required this.userId});

  @override
  State<ProfileView> createState() => _ProfileViewState();
  static const String routeName = '/profile';
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    int userId = widget.userId;
    User currentUser =
        DUMMY_USERS.where((element) => element.id == userId).toList()[0];
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '${currentUser.username}',
            style: kAppBarTitleTextStyle,
          ),
          backgroundColor: AppColors.primary,
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 32),
                            child: CircleAvatar(
                              backgroundColor: AppColors.primary,
                              radius: 80,
                              child: Image.network(
                                currentUser.photo,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.more_horiz,
                          size: 32,
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        currentUser.name,
                        style: kHeading2TextStyle,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        currentUser.bio,
                        style: kLabelStyle,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${currentUser.followers.length} followers",
                            style: kBoldLabelStyle,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            "${currentUser.following.length} following",
                            style: kBoldLabelStyle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: TabBar(
                  indicatorColor: AppColors.primary,
                  labelStyle: kLabelStyle,
                  labelColor: AppColors.textColor,
                  tabs: [
                    Tab(
                      text: "Posts",
                    ),
                    Tab(
                      text: "Locations",
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Container(child: StaggeredGridPosts.user(1, currentUser.username)),
                    Container(child: Text("Locations will go here"))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

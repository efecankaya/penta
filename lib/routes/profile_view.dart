import 'package:flutter/material.dart';
import 'package:penta/util/colors.dart';
import 'package:penta/util/styles.dart';
import 'package:penta/util/screenSizes.dart';
import 'package:penta/model/user.dart';
import 'package:penta/model/dummy_data.dart';
import 'package:penta/ui/staggered_grid_posts.dart';
import 'package:penta/ui/popup_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:penta/routes/edit_profile_view.dart';
import 'package:penta/routes/settings_view.dart';
import 'package:penta/util/arguments.dart';
import 'package:penta/firebase/analytics.dart';

class ProfileView extends StatefulWidget {
  final int userId;

  const ProfileView({required this.userId});

  @override
  State<ProfileView> createState() => _ProfileViewState();
  static const String routeName = '/profile';
}

class _ProfileViewState extends State<ProfileView>
    with SingleTickerProviderStateMixin {
  final List<Widget> myTabs = [
    const Tab(text: "Posts"),
    const Tab(text: "Locations"),
  ];
  late TabController _tabController;
  late ScrollController _scrollController;

  //Builds the general information part of the page. (Everything above the tabs)
  Widget _buildCarousel() {
    int userId = widget.userId;
    //Get the user from its id as a User object. Find method subject to change.
    User currentUser =
        DUMMY_USERS.where((element) => element.id == userId).toList()[0];
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth(context, dividedBy: 2) - 90),
                    child: CircleAvatar(
                      backgroundColor: AppColors.primary,
                      radius: 80,
                      backgroundImage: NetworkImage(
                        currentUser.photo,
                      ),
                    ),
                  ),
                  Spacer(),
                  currentUser.id == 0
                      ? PopupMenu(
                          menuList: [
                            PopupMenuItem(
                              child: ListTile(
                                leading: Icon(Icons.edit),
                                title: Text(
                                  "Edit Profile",
                                  style: kLabelStyle,
                                ),
                              ),
                              onTap: () async {
                                await Future.delayed(Duration.zero);
                                Navigator.pushNamed(
                                  context,
                                  EditProfileView.routeName,
                                  arguments: userId,
                                );
                              },
                            ),
                            PopupMenuItem(
                              child: ListTile(
                                leading: Icon(Icons.settings),
                                title: Text(
                                  "Settings",
                                  style: kLabelStyle,
                                ),
                              ),
                              onTap: () async {
                                await Future.delayed(Duration.zero);
                                Navigator.pushNamed(
                                  context,
                                  SettingsView.routeName,
                                );
                              },
                            ),
                            PopupMenuItem(
                              child: ListTile(
                                leading: Icon(Icons.logout),
                                title: Text(
                                  "Log Out",
                                  style: kLabelStyle,
                                ),
                                onTap: () async {
                                  Analytics.logCustomEvent(
                                    "logout",
                                    null,
                                  );
                                  final SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setBool("loggedIn", false);
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    "/",
                                    (r) => false,
                                    arguments: RootArguments(loggedIn: false),
                                  );
                                  //Argument false means that user wants to log out
                                },
                              ),
                            ),
                          ],
                          icon: Icon(
                            Icons.more_horiz,
                            size: 32,
                          ),
                        )
                      : Icon(
                          Icons.more_horiz,
                          size: 32,
                        ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  currentUser.name,
                  style: kHeading2TextStyle,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  currentUser.bio,
                  style: kLabelStyle,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${currentUser.followers.length} followers",
                      style: kBoldLabelStyle,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      "${currentUser.following.length} following",
                      style: kBoldLabelStyle,
                    ),
                  ],
                ),
              ),
              currentUser.id == 0
                  ? SizedBox.shrink()
                  : Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlinedButton(
                            onPressed: () {},
                            child: Text(
                              "Follow",
                              style: kSmallButtonLightTextStyle,
                            ),
                            style: OutlinedButton.styleFrom(
                              fixedSize: const Size(130, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              "Message",
                              style: kSmallButtonDarkTextStyle,
                            ),
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(130, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  //Get the posts of this user
  _buildTabContext(String username) => Container(
        child: ListView.builder(
          physics: const ClampingScrollPhysics(),
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return StaggeredGridPosts(username: username);
          },
        ),
      );

  @override
  Widget build(BuildContext context) {
    int userId = widget.userId;
    //Get user by their id. Find method subject to change.
    User currentUser =
        DUMMY_USERS.where((element) => element.id == userId).toList()[0];
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            currentUser.username,
            style: kAppBarTitleTextStyle,
          ),
          backgroundColor: AppColors.primary,
          centerTitle: true,
          elevation: 0.0,
        ),
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, value) {
            return [
              SliverToBoxAdapter(
                child: _buildCarousel(),
              ),
              SliverToBoxAdapter(
                child: Container(
                  child: TabBar(
                    indicatorColor: AppColors.primary,
                    labelStyle: kLabelStyle,
                    labelColor: AppColors.textColor,
                    controller: _tabController,
                    tabs: myTabs,
                  ),
                ),
              ),
            ];
          },
          body: Container(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTabContext(currentUser.username),
                //TODO: implement locations
                const Text("The locations will go here"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

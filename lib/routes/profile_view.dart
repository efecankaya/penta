import 'package:flutter/material.dart';
import 'package:penta/util/colors.dart';
import 'package:penta/util/styles.dart';
import 'package:penta/model/user.dart';
import 'package:penta/model/dummy_data.dart';
import 'package:penta/ui/staggered_grid_posts.dart';
import 'package:penta/ui/popup_menu.dart';

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
  bool fixedScroll = false;

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
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 32),
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
                  PopupMenu(
                    menuList: [
                      PopupMenuItem(
                        child: ListTile(
                          leading: Icon(Icons.settings),
                          title: Text(
                            "Settings",
                            style: kLabelStyle,
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        child: ListTile(
                          leading: Icon(Icons.exit_to_app),
                          title: Text(
                            "Log out",
                            style: kLabelStyle,
                          ),
                        ),
                      ),
                    ],
                    icon: Icon(
                      Icons.more_horiz,
                      size: 32,
                    ),
                  )
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

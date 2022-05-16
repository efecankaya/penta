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

class _ProfileViewState extends State<ProfileView> with SingleTickerProviderStateMixin {
  final List<Widget> myTabs = [
    Tab(text: "Posts"),
    Tab(text: "Locations"),
  ];
  late TabController _tabController;
  late ScrollController _scrollController;
  bool fixedScroll = false;

  Widget _buildCarousel() {
    int userId = widget.userId;
    User currentUser =
        DUMMY_USERS.where((element) => element.id == userId).toList()[0];
    return Column(
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
      ],
    );
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_smoothScrollToTop);

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  _scrollListener() {
    if (fixedScroll) {
      _scrollController.jumpTo(0);
    }
  }

  _smoothScrollToTop() {
    _scrollController.animateTo(
      0,
      duration: Duration(microseconds: 300),
      curve: Curves.ease,
    );

    setState(() {
      //fixedScroll = _tabController.index == 2;
    });
  }

  _buildTabContext(String username) => Container(
    child: ListView.builder(
      physics: const ClampingScrollPhysics(),
      itemCount: 1,
      itemBuilder: (BuildContext context, int index) {
        return StaggeredGridPosts.user(1, username);
      },
    ),
  );

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
                Text("The locations will go here"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

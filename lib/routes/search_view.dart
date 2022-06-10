import 'package:flutter/material.dart';
import 'package:penta/util/colors.dart';
import 'package:penta/util/styles.dart';
import 'package:penta/model/dummy_data.dart';
import 'package:penta/model/post.dart';
import 'package:penta/ui/staggered_grid_posts.dart';
import 'package:penta/model/user.dart';
import 'package:penta/routes/profile_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class SearchView extends StatefulWidget {
  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView>
    with SingleTickerProviderStateMixin {
  final List<Widget> searchTabs = [
    const Tab(text: "Posts"),
    const Tab(text: "Accounts"),
    const Tab(text: "Topics"),
    const Tab(text: "Places"),
  ];
  late TabController _tabController;
  late ScrollController _scrollController;
  List<Post>? allPosts;
  List<Post>? currentPosts;
  List<Profile> users = DUMMY_USERS;

  String query = '';

  @override
  void initState() {
    _scrollController = ScrollController();
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
    this.getPosts();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  buildPosts() {
    if (currentPosts != null) {
      return StaggeredGridPosts(posts: currentPosts!);
    } else {
      return Container(
          alignment: FractionalOffset.center,
          child: CircularProgressIndicator());
    }
  }

  getPosts() async {
    QuerySnapshot postSnapshot = await FirebaseFirestore.instance.collection("Posts").get();
    allPosts = postSnapshot.docs.map((doc) => Post.fromMap(doc.data() as Map<String,dynamic>)).toList();
    currentPosts = allPosts;
  }

  _buildPostsTabContext(List<Post>? posts) => Container(
        child: ListView.builder(
          physics: const ClampingScrollPhysics(),
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return buildPosts();
          },
        ),
      );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Search",
            style: kAppBarTitleTextStyle,
          ),
          backgroundColor: AppColors.primary,
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Column(
          children: [
            SearchWidget(
              text: query,
              hintText: "Search...",
              onChanged: search,
            ),
            Container(
              child: TabBar(
                indicatorColor: AppColors.primary,
                labelStyle: kLabelStyle,
                labelColor: AppColors.textColor,
                controller: _tabController,
                tabs: searchTabs,
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildPostsTabContext(currentPosts),
                  AccountSearch(context, users),
                  const Text("The topics will go here"),
                  const Text("The locations will go here"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void search(String query) {
    final resultPosts = allPosts!.where((post) {
      final descriptionLower = post.description.toLowerCase();
      final searchLower = query.toLowerCase();

      return descriptionLower.contains(searchLower);
    }).toList();
    final users = DUMMY_USERS.where((User) {
      final descriptionLower = User.username.toLowerCase();
      final searchLower = query.toLowerCase();

      return descriptionLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.currentPosts = resultPosts;
      this.users = users;
    });
  }
}

class SearchWidget extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;

  const SearchWidget({
    Key? key,
    required this.text,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final styleActive = TextStyle(color: Colors.black);
    final styleHint = TextStyle(color: Colors.black54);
    final style = widget.text.isEmpty ? styleHint : styleActive;

    return Container(
      height: 42,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: Colors.black26),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          icon: Icon(
            Icons.search,
            color: style.color,
          ),
          suffixIcon: widget.text.isEmpty
              ? GestureDetector(
                  child: Icon(
                    Icons.close,
                    color: style.color,
                  ),
                  onTap: () {
                    controller.clear();
                    widget.onChanged('');
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                )
              : null,
          hintText: widget.hintText,
          hintStyle: style,
          border: InputBorder.none,
        ),
        style: style,
        onChanged: widget.onChanged,
      ),
    );
  }
}

Widget AccountSearch(context, List<Profile> Users) {
  var list = <Widget>[];
  for (var i = 0; i < Users.length; i++) {
    list.add(
      Column(
        children: [
          GestureDetector(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.primary,
                  backgroundImage: NetworkImage(
                    Users[i].photoUrl,
                  ),
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: kLabelStyle,
                      children: <TextSpan>[
                        TextSpan(
                          text: "    ${Users[i].username}  ",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            onTap: () {
              Profile currentUser = DUMMY_USERS
                  .where(
                      (element) => element.username == "${Users[i].username}")
                  .toList()[0];
              Navigator.pushNamed(context, ProfileView.routeName,
                  arguments: currentUser.uid);
            },
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
  return SingleChildScrollView(
    child: Padding(padding: EdgeInsets.all(10), child: Column(children: list)),
  );
}

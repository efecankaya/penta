import 'package:flutter/material.dart';
import 'package:penta/util/colors.dart';
import 'package:penta/util/styles.dart';
import 'package:penta/model/dummy_data.dart';
import 'package:penta/model/post.dart';
import 'package:penta/ui/staggered_grid_posts.dart';

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

  List<Post> posts = DUMMY_POSTS;
  String query = '';

  @override
  void initState() {
    _scrollController = ScrollController();
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  _buildPostsTabContext(List<Post> posts) => Container(
        child: ListView.builder(
          physics: const ClampingScrollPhysics(),
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return StaggeredGridPosts.custom(posts: posts);
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
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, value) {
            return [
              SliverToBoxAdapter(
                child: SearchWidget(
                  text: query,
                  hintText: "Search...",
                  onChanged: search,
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  child: TabBar(
                    indicatorColor: AppColors.primary,
                    labelStyle: kLabelStyle,
                    labelColor: AppColors.textColor,
                    controller: _tabController,
                    tabs: searchTabs,
                  ),
                ),
              ),
            ];
          },
          body: Container(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildPostsTabContext(posts),
                const Text("The accounts will go here"),
                const Text("The topics will go here"),
                const Text("The locations will go here"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void search(String query) {
    final posts = DUMMY_POSTS.where((post) {
      final descriptionLower = post.description.toLowerCase();
      final searchLower = query.toLowerCase();

      return descriptionLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.posts = posts;
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
      margin: const EdgeInsets.all(16),
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

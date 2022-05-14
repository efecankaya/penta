import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:penta/util/colors.dart';
import 'package:penta/util/dimensions.dart';
import 'package:penta/util/styles.dart';

class FeedView extends StatefulWidget {
  const FeedView({Key? key}) : super(key: key);

  @override
  State<FeedView> createState() => _FeedViewState();
  static const String routeName = '/feed';
}

class _FeedViewState extends State<FeedView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Feed',
          style: kAppBarTitleTextStyle,
        ),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: StaggeredGrid.count(
          crossAxisCount: 2,
          children: List.generate(
            12,
            (int i) {
              return _Tile(i);
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/icons/home-dark.png",
              width: 20,
              height: 20,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/icons/search.png",
              width: 20,
              height: 20,
            ),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/icons/add.png",
              width: 20,
              height: 20,
            ),
            label: "Add",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/icons/envelope.png",
              width: 20,
              height: 20,
            ),
            label: "Notifications",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/icons/user.png",
              width: 20,
              height: 20,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  _Tile(this.i);

  final int i;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        child: InkWell(
          onTap: () {},
          child: Hero(
            child: Image.asset("assets/images/$i.jpeg"),
            tag: "assets/images/$i.jpeg",
          ),
        ),
      ),
    );
  }
}

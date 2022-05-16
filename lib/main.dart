import 'package:flutter/material.dart';
import 'package:penta/routes/login_view.dart';
import 'package:penta/routes/signup_view.dart';
import 'package:penta/routes/welcome_view.dart';
import 'package:penta/routes/feed_view.dart';
import 'package:penta/routes/post_view.dart';
import 'package:penta/routes/search_view.dart';
import 'package:penta/routes/upload_view.dart';
import 'package:penta/routes/messages_view.dart';
import 'package:penta/routes/profile_view.dart';
import 'package:penta/util/colors.dart';

void main() {
  runApp(Penta());
}

class Penta extends StatelessWidget {
  const Penta({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Penta",
      onGenerateRoute: (settings) {
        if(settings.name == ProfileView.routeName) {
          int userId = settings.arguments as int? ?? 0;
          return MaterialPageRoute(builder: (_) => ProfileView(userId: userId));
        }
      },
      routes: {
        '/': (context) => MainView(),
        SignUpView.routeName: (context) => SignUpView(),
        LoginView.routeName: (context) => LoginView(),
        FeedView.routeName: (context) => FeedView(),
        PostView.routeName: (context) => PostView(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.quaternary,
          secondary: AppColors.primary,
        ),
        primaryIconTheme: IconThemeData(color: AppColors.primary),
      ),
    );
  }
}

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int currentIndex = 0;
  final screens = [
    FeedView(),
    SearchView(),
    UploadView(),
    MessagesView(),
    ProfileView(userId: 0),
  ];

  @override
  Widget build(BuildContext context) {
    bool loggedIn =
        ModalRoute.of(context)!.settings.arguments as bool? ?? false;
    return (!loggedIn)
        ? WelcomeView()
        : Scaffold(
            body: IndexedStack(
              index: currentIndex,
              children: screens,
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: AppColors.primary,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              iconSize: 35,
              currentIndex: currentIndex,
              onTap: (index) => setState(() => currentIndex = index),
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: "Search",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add_circle_outline),
                  label: "Create",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.mail),
                  label: "Messages",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "Profile",
                ),
              ],
            ),
          );
  }
}

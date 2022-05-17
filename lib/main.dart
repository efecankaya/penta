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
import 'package:penta/util/tab_navigator.dart';

void main() {
  runApp(Penta());
}

class Penta extends StatelessWidget {
  const Penta({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Penta",
      routes: {
        '/': (context) => MainView(),
        SignUpView.routeName: (context) => SignUpView(),
        LoginView.routeName: (context) => LoginView(),
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
  String currentPage = "feed";
  List<String> pageKeys = ["feed", "search", "upload", "messages", "profile"];
  Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "feed": GlobalKey<NavigatorState>(),
    "search": GlobalKey<NavigatorState>(),
    "upload": GlobalKey<NavigatorState>(),
    "messages": GlobalKey<NavigatorState>(),
    "profile": GlobalKey<NavigatorState>(),
  };

  void _selectTab(String tabItem, int index) {
    if (tabItem == currentPage) {
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        currentPage = pageKeys[index];
        currentIndex = index;
      });
    }
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: currentPage != tabItem,
      child: Navigator(
        key: _navigatorKeys[tabItem],
        onGenerateRoute: (settings) {
          if (settings.name == "/") {
            return MaterialPageRoute(
              builder: (_) => TabNavigator(
                tabItem: tabItem,
              ),
            );
          }
          if (settings.name == ProfileView.routeName) {
            int userId = settings.arguments as int? ?? 0;
            return MaterialPageRoute(
                builder: (_) => ProfileView(userId: userId));
          }
          if (settings.name == PostView.routeName) {
            var args = settings.arguments as PostArguments;
            return MaterialPageRoute(builder: (_) => PostView(args));
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool loggedIn =
        ModalRoute.of(context)!.settings.arguments as bool? ?? false;
    return (!loggedIn)
        ? WelcomeView()
        : WillPopScope(
            child: Scaffold(
              body: Stack(
                children: [
                  _buildOffstageNavigator("feed"),
                  _buildOffstageNavigator("search"),
                  _buildOffstageNavigator("upload"),
                  _buildOffstageNavigator("messages"),
                  _buildOffstageNavigator("profile"),
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: AppColors.primary,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                iconSize: 35,
                currentIndex: currentIndex,
                onTap: (index) {
                  _selectTab(pageKeys[index], index);
                },
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
            ),
            onWillPop: () async {
              final isFirstRouteInCurrentTab =
                  !await _navigatorKeys[currentPage]!.currentState!.maybePop();
              if (isFirstRouteInCurrentTab) {
                if (currentPage != "feed") {
                  _selectTab("feed", 1);

                  return false;
                }
              }
              return isFirstRouteInCurrentTab;
            },
          );
  }
}

import 'package:flutter/material.dart';
import 'package:penta/routes/login_view.dart';
import 'package:penta/routes/signup_view.dart';
import 'package:penta/routes/welcome_view.dart';
import 'package:penta/routes/post_view.dart';
import 'package:penta/routes/profile_view.dart';
import 'package:penta/util/colors.dart';
import 'package:penta/util/tab_navigator.dart';
import 'package:penta/model/post.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:penta/routes/edit_profile_view.dart';
import 'package:penta/routes/settings_view.dart';

void main() {
  runApp(const Penta());
}

class Penta extends StatelessWidget {
  const Penta({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Penta",
      routes: {
        '/': (context) => const MainView(),
        SignUpView.routeName: (context) => SignUpView(),
        LoginView.routeName: (context) => LoginView(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.quaternary,
          secondary: AppColors.primary,
        ),
        primaryIconTheme: const IconThemeData(color: AppColors.primary),
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
  bool exit = false;
  bool? loggedIn;

  //These are for the bottom navigation bar (and for it to be persistent).
  //Each tab should have its own navigation stack.
  int currentIndex = 0;
  String currentPage = "feed";
  List<String> pageKeys = ["feed", "search", "upload", "messages", "profile"];
  final Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "feed": GlobalKey<NavigatorState>(),
    "search": GlobalKey<NavigatorState>(),
    "upload": GlobalKey<NavigatorState>(),
    "messages": GlobalKey<NavigatorState>(),
    "profile": GlobalKey<NavigatorState>(),
  };

  //If user taps on the tab that they are already on,
  //that tab's stack should be popped until the first element.
  //Else, select that tab.
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

  //Offstage is used so that the states are preserved if the page goes out of view.
  Widget _buildOffstageNavigator(String tabItem, Function() refresh) {
    return Offstage(
      //Hide the page if that page's tab is not selected.
      offstage: currentPage != tabItem,
      child: Navigator(
        key: _navigatorKeys[tabItem],
        //New navigation routes should be added inside onGenerateRoute
        onGenerateRoute: (settings) {
          if (settings.name == "/") {
            if (settings.arguments == false) {
              //User wants to log out
              exit = true;
              refresh(); //Update the Main View
              return null;
            }
            //Base of the navigation stack of the current tab.
            return MaterialPageRoute(
              //A view should be returned based on the tabItem that is selected.
              builder: (_) => TabNavigator(
                tabItem: tabItem,
              ),
            );
          } else if (settings.name == ProfileView.routeName) {
            //Add a user's profile view to this tab's navigation stack.
            int userId = settings.arguments as int? ?? 0;
            return MaterialPageRoute(
                builder: (_) => ProfileView(userId: userId));
          } else if (settings.name == PostView.routeName) {
            //Add a post view to this tab's navigation stack.
            var currentPost = settings.arguments as Post;
            return MaterialPageRoute(builder: (_) => PostView(currentPost));
          } else if (settings.name == EditProfileView.routeName) {
            int userId = settings.arguments as int? ?? 0;
            return MaterialPageRoute(builder: (_) => EditProfileView(userId));
          } else if (settings.name == SettingsView.routeName) {
            return MaterialPageRoute(builder: (_) => SettingsView());
          } else {
            return null;
          }
        },
      ),
    );
  }

  //Set loggedIn information via shared preferences
  Future setLoggedIn(bool loggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('loggedIn', loggedIn);
  }

  //Get loggedIn information via shared preferences. May be null.
  Future getLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    loggedIn = prefs.getBool('loggedIn');
  }

  @override
  void initState() {
    super.initState();
    //Set loggedIn to false if it does not exist in shared preferences.
    getLoggedIn().whenComplete(() {
      if (loggedIn == null) {
        loggedIn = false;
        setLoggedIn(false);
      }
      refresh();
    });
  }

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (exit) {
      //User pressed log out in the profile view.
      loggedIn = false;
      exit = false;
      return const WelcomeView();
    }

    //Local non-nullable version of loggedIn
    bool l = loggedIn ?? false;

    if (loggedIn == null) {
      //The async function hasn't gotten loggedIn yet.
      return Scaffold(
        body: Center(
          child: Text("Loading..."),
        ),
      );
    } else if (!l) {
      //If user is not logged in
      return const WelcomeView();
    } else {
      //If user is logged in
      return WillPopScope(
        child: Scaffold(
          body: Stack(
            children: [
              _buildOffstageNavigator("feed", refresh),
              _buildOffstageNavigator("search", refresh),
              _buildOffstageNavigator("upload", refresh),
              _buildOffstageNavigator("messages", refresh),
              _buildOffstageNavigator("profile", refresh),
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
            items: const [
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
                icon: Icon(Icons.notifications),
                label: "Messages",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
          ),
        ),

        //This is for the navigation bar at the bottom of the android phone.
        //If the current tab has no previous elements in the navigation stack,
        //going back will result in going to the feed page.
        //If user is already on the feed page and there are no previous elements,
        //then going back will exit the app.
        onWillPop: () async {
          final isFirstRouteInCurrentTab =
              !await _navigatorKeys[currentPage]!.currentState!.maybePop();
          if (isFirstRouteInCurrentTab) {
            if (currentPage != "feed") {
              _selectTab("feed", 0);
              return false;
            }
          }
          return isFirstRouteInCurrentTab;
        },
      );
    }
  }
}

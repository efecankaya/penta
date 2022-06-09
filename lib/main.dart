import 'package:flutter/material.dart';
import 'package:penta/routes/login_view.dart';
import 'package:penta/routes/signup_view.dart';
import 'package:penta/routes/create_profile_view.dart';
import 'package:penta/routes/welcome_view.dart';
import 'package:penta/routes/post_view.dart';
import 'package:penta/routes/profile_view.dart';
import 'package:penta/util/colors.dart';
import 'package:penta/util/tab_navigator.dart';
import 'package:penta/model/post.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:penta/routes/edit_profile_view.dart';
import 'package:penta/routes/settings_view.dart';
import 'package:penta/routes/walkthrough_view.dart';
import 'package:penta/util/arguments.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:penta/firebase/analytics.dart';

bool? initialLoad;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initialLoad = prefs.getBool("initialLoad");

  runApp(Penta());
}

class Penta extends StatelessWidget {
  Penta({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Penta",
      initialRoute: "/",
      routes: {
        SignUpView.routeName: (context) => SignUpView(),
        LoginView.routeName: (context) => LoginView(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == "/") {
          bool nullArgs = settings.arguments == null;
          late bool i;
          if (nullArgs) {
            i = initialLoad ?? true;
          } else {
            RootArguments args = settings.arguments! as RootArguments;
            i = args.initialLoad!;
          }
          if (i) {
            Analytics.logCustomEvent(
              "walkthrough_view",
              null,
            );
          }
          return MaterialPageRoute(
            builder: (_) => i ? WalkthroughView() : MainView(),
          );
        }
        else if (settings.name == "/profile/create") {
          return MaterialPageRoute(
            builder: (_) => CreateProfileView(0),
          );
        }
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
  const MainView({
    Key? key,
  }) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  bool exit = false;
  bool? loggedIn;

  //These are for the bottom navigation bar (and for it to be persistent).
  //Each tab should have its own navigation stack.
  int currentIndex = 0;
  String currentPage = "feed_view";
  List<String> pageKeys = [
    "feed_view",
    "search_view",
    "upload_view",
    "messages_view",
    "profile_view"
  ];
  final Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "feed_view": GlobalKey<NavigatorState>(),
    "search_view": GlobalKey<NavigatorState>(),
    "upload_view": GlobalKey<NavigatorState>(),
    "messages_view": GlobalKey<NavigatorState>(),
    "profile_view": GlobalKey<NavigatorState>(),
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
            bool nullArgs = settings.arguments == null;
            late bool l;
            if (nullArgs) {
              l = true;
            } else {
              RootArguments args = settings.arguments! as RootArguments;
              l = args.loggedIn!;
            }
            if (l == false) {
              //User wants to log out
              exit = true;
              refresh(); //Update the Main View
              return MaterialPageRoute(
                builder: (_) => Scaffold(
                  body: Container(),
                ),
              );
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
            Analytics.logCustomEvent(
              "profile_view",
              {"user_id": userId},
            );
            return MaterialPageRoute(
                builder: (_) => ProfileView(userId: userId));
          } else if (settings.name == PostView.routeName) {
            //Add a post view to this tab's navigation stack.
            var currentPost = settings.arguments as Post;
            Analytics.logCustomEvent(
              "post_view",
              {"post_id": currentPost.ownerId},
            );
            return MaterialPageRoute(builder: (_) => PostView(currentPost));
          } else if (settings.name == EditProfileView.routeName) {
            int userId = settings.arguments as int? ?? 0;
            Analytics.logCustomEvent(
              "edit_profile_view",
              {"user_id": userId},
            );
            return MaterialPageRoute(builder: (_) => EditProfileView(userId));
          } else if (settings.name == SettingsView.routeName) {
            Analytics.logCustomEvent(
              "settings_view",
              null,
            );
            return MaterialPageRoute(builder: (_) => SettingsView());
          } else {
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Container(
                  child: Center(
                    child: Text("Unknown page."),
                  ),
                ),
              ),
            );
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
      Analytics.logCustomEvent(
        "welcome_view",
        null,
      );
      return const WelcomeView();
    }

    //Local non-nullable version of loggedIn
    bool l = loggedIn ?? false;

    if (loggedIn == null) {
      //The async function didn't return yet.
      return Scaffold(
        body: Center(
          child: Text("Loading..."),
        ),
      );
    } else if (!l) {
      //If user is not logged in
      Analytics.logCustomEvent(
        "welcome_view",
        null,
      );
      return const WelcomeView();
    } else {
      //If user is logged in
      return WillPopScope(
        child: Scaffold(
          body: Stack(
            children: [
              _buildOffstageNavigator("feed_view", refresh),
              _buildOffstageNavigator("search_view", refresh),
              _buildOffstageNavigator("upload_view", refresh),
              _buildOffstageNavigator("messages_view", refresh),
              _buildOffstageNavigator("profile_view", refresh),
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
              Analytics.logCustomEvent(pageKeys[index], null);
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
            if (currentPage != "feed_view") {
              _selectTab("feed_view", 0);
              return false;
            }
          }
          return isFirstRouteInCurrentTab;
        },
      );
    }
  }
}

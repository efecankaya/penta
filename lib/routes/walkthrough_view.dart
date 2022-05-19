import 'package:flutter/material.dart';
import 'package:penta/util/colors.dart';
import 'package:penta/util/styles.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:penta/util/arguments.dart';

class WalkthroughView extends StatefulWidget {
  const WalkthroughView({Key? key}) : super(key: key);

  @override
  State<WalkthroughView> createState() => _WalkthroughViewState();
}

class _WalkthroughViewState extends State<WalkthroughView> {
  final controller = PageController();
  int currentPage = 0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget _buildPage({
    required String image,
    required String title,
    required String subtitle,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.width * 0.6,
            width: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(image))),
          ),
          SizedBox(
            height: 60.0,
          ),
          Text(
            title,
            style: kHeadingTextStyle,
          ),
          SizedBox(
            height: 15.0,
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                subtitle,
                style: kLabelStyle,
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      );

  _storeWalkthroughInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("initialLoad", false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() => currentPage = index);
          },
          children: [
            _buildPage(
              image: 'assets/icons/penta-transparent.png',
              title: "Welcome to Penta!",
              subtitle: "The only social media application you need.",
            ),
            _buildPage(
              image: 'assets/walkthrough/walkthrough_1.png',
              title: "Explore",
              subtitle: "Explore your favorite topics.",
            ),
            _buildPage(
              image: 'assets/walkthrough/walkthrough_2.png',
              title: "Connect",
              subtitle: "Connect with new people.",
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Visibility(
              child: TextButton(
                onPressed: () => controller.previousPage(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                ),
                child: Text(
                  'PREV',
                  style: kWalkthroughButtonTextStyle,
                ),
              ),
              visible: currentPage != 0,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
            ),
            Visibility(
              child: Center(
                child: SmoothPageIndicator(
                  controller: controller,
                  count: 3,
                  effect: WormEffect(
                    spacing: 16,
                    dotColor: Colors.black26,
                    activeDotColor: AppColors.primary,
                  ),
                  onDotClicked: (index) => controller.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeIn,
                  ),
                ),
              ),
              visible: currentPage != 2,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
            ),
            currentPage != 2
                ? TextButton(
                    onPressed: () => controller.nextPage(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                    ),
                    child: Text(
                      'NEXT',
                      style: kWalkthroughButtonTextStyle,
                    ),
                  )
                : TextButton(
                    onPressed: () {
                      _storeWalkthroughInfo();
                      Navigator.pushReplacementNamed(
                        context,
                        "/",
                        arguments: RootArguments(initialLoad: false),
                      );
                    },
                    child: Text(
                      'GET STARTED',
                      style: kWalkthroughButtonTextStyle,
                    ),
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2))),
                  )
          ],
        ),
      ),
    );
  }
}

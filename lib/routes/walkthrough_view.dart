import 'package:flutter/material.dart';

class WalkthroughView extends StatefulWidget {
  @override
  _WalkthroughViewState createState() => _WalkthroughViewState();
}

class _WalkthroughViewState extends State<WalkthroughView> {
  int currentPage = 0;
  int lastPage = 3;

  List<String> titles = [
    'Welcome To Penta',
    'Bla Bla Bla',
    'Hello guys',
    'Lets sign up'
  ];
  List<String> headings = [
    'Welcome to Your World',
    'See your friends',
    'Newest news',
    'Lets Create your Account'
  ];
  List<String> captions = [
    'We crate a world for you',
    'Your friends are here',
    'You can add new posts',
    'you are the best'
  ];

  List<IconData> images = [
    Icons.start,
    Icons.add,
    Icons.volume_down,
    Icons.volume_up
  ];

  void nextPage() {
    if (currentPage < lastPage) {
      setState(() {
        currentPage += 1;
      });
    }
  }

  void prevPage() {
    if (currentPage > 0) {
      setState(() {
        currentPage -= 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5743BD),
      appBar: AppBar(
        backgroundColor: const Color(0xFF261780),
        title: Text(
          titles[currentPage].toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            letterSpacing: -1,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  headings[currentPage],
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -1.0,
                  ),
                ),
              ),
            ),
            Container(
              height: 280,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0), //or 15.0
                child: Container(
                  height: 150.0,
                  width: 300.0,
                  color: Color(0xffFF0E58),
                  child: Icon(images[currentPage],
                      color: Colors.white, size: 150.0),
                ),
              ),
            ),
            Center(
              child: Text(
                captions[currentPage],
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                  letterSpacing: -1.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 80,
                child: Row(
                  children: [
                    Container(
                      height: 30,
                      color: Colors.deepPurple,
                      child: OutlinedButton(
                        child: Container(
                          child: Text(
                            'Previous',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onPressed: prevPage,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '${currentPage + 1}/${lastPage + 1}',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: 30,
                      color: Colors.deepPurple,
                      child: OutlinedButton(
                        child: Container(
                          width: 45,
                          child: Text(
                            'Next',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onPressed: nextPage,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

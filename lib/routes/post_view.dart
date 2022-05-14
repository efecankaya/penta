import 'package:flutter/material.dart';
import 'package:penta/util/colors.dart';
import 'package:penta/util/styles.dart';
import 'package:penta/util/screenSizes.dart';

class PostView extends StatefulWidget {
  @override
  _PostViewState createState() => _PostViewState();

  static const String routeName = '/post';
}

class _PostViewState extends State<PostView> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as PostArguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          args.image,
          style: kAppBarTitleTextStyle,
        ),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Hero(
            tag: args.image,
            child: Image.asset(
              args.image,
              fit: BoxFit.cover,
              width: screenWidth(context),
              alignment: Alignment.center,
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Text(
              args.image,
              style: kLabelStyle,
            ),
          ),
        ],
      ),
    );
  }
}

class PostArguments {
  final String image;

  PostArguments(this.image);
}

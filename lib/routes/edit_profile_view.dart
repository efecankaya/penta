import 'package:flutter/material.dart';
import 'package:penta/util/colors.dart';
import 'package:penta/util/styles.dart';
import 'package:penta/model/user.dart';
import 'package:penta/model/dummy_data.dart';

class EditProfileView extends StatefulWidget {
  final int userId;

  EditProfileView(this.userId);

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
  static const String routeName = '/profile/edit';
}

class _EditProfileViewState extends State<EditProfileView> {
  @override
  Widget build(BuildContext context) {
    User currentUser =
        DUMMY_USERS.where((element) => element.id == widget.userId).toList()[0];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: kAppBarTitleTextStyle,
        ),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 160,
                      height: 160,
                      child: CircleAvatar(
                        backgroundColor: AppColors.primary,
                        radius: 80,
                        child: Image.network(
                          currentUser.photo,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: AppColors.quaternary,
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            )),
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  color: Color(0xFF737373),
                                  height: 120,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).canvasColor,
                                      borderRadius: BorderRadius.only(
                                        topLeft: const Radius.circular(10),
                                        topRight: const Radius.circular(10),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          title: Center(
                                            child: Text("Take Photo"),
                                          ),
                                          //Don't forget to add Navigator.pop(context)
                                          onTap: () =>
                                              print("tapped take photo"),
                                        ),
                                        ListTile(
                                          title: Center(
                                            child: Text("Choose From Library"),
                                          ),
                                          onTap: () =>
                                              print("tapped choose photo"),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 3),
                  labelText: "Name",
                  labelStyle: kLabelStyle,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: currentUser.name,
                  hintStyle: kHint2LabelStyle,
                ),
              ),
              SizedBox(
                height: 35,
              ),
              TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 3),
                  labelText: "Bio",
                  labelStyle: kLabelStyle,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: currentUser.bio,
                  hintStyle: kHint2LabelStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

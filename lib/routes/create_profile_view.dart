import 'package:flutter/material.dart';
import 'package:penta/util/colors.dart';
import 'package:penta/util/styles.dart';
import 'package:penta/model/user.dart';
import 'package:penta/model/dummy_data.dart';
import 'package:penta/firebase/analytics.dart';
import 'package:penta/firebase/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:penta/util/arguments.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:penta/util/pickImage.dart';

class CreateProfileView extends StatefulWidget {
  //final User? user = Authentication.firebaseAuth.currentUser;
  final UserCredential cred;
  final String username;
  final String email;

  CreateProfileView(this.cred, this.username, this.email);

  @override
  State<CreateProfileView> createState() => _CreateProfileViewState();
  static const String routeName = '/profile/create';
}

class _CreateProfileViewState extends State<CreateProfileView> {
  final _formKey = GlobalKey<FormState>();
  String name = "";
  String bio = "";
  Uint8List? _image;

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Profile",
          style: kAppBarTitleTextStyle,
        ),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Form(
            key: _formKey,
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
                          backgroundImage: _image != null
                              ? MemoryImage(_image!) as ImageProvider<Object>
                              : NetworkImage(
                                  'https://i.stack.imgur.com/l60Hf.png'),
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
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
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
                                              child:
                                                  Text("Choose From Library"),
                                            ),
                                            onTap: selectImage,
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
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: "Name",
                    labelStyle: kLabelStyle,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  onSaved: (value) {
                    name = value ?? '';
                  },
                  validator: (value) {
                    if (value != null) {
                      if (value.isEmpty) {
                        return 'Cannot leave name empty';
                      }
                    }
                  },
                ),
                SizedBox(
                  height: 35,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: "Bio",
                    labelStyle: kLabelStyle,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  onSaved: (value) {
                    bio = value ?? '';
                  },
                  validator: (value) {
                    /*
                  if (value != null) {
                    if (value.isEmpty) {
                      return 'Cannot leave bio empty';
                    }
                  }
                  */
                  },
                ),
                SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OutlinedButton(
                      onPressed: () {},
                      child: Text(
                        "CANCEL",
                        style: kSmallButtonLightTextStyle,
                      ),
                      style: OutlinedButton.styleFrom(
                        fixedSize: const Size(150, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          print("reached 1 $name");
                          String photoUrl = await Authentication.uploadImageToStorage('profilePics', _image == null ? Uint8List(0) : _image!, false);
                          Profile user = Profile(
                            name: name,
                            username: widget.username,
                            uid: widget.cred.user!.uid,
                            photoUrl: photoUrl,
                            email: widget.email,
                            bio: bio,
                            followers: [],
                            following: [],
                          );
                          print("reached 2");
                          Authentication.writeUserInfo(
                              user: user, cred: widget.cred);
                          print("reached 3");
                          Analytics.logSignUp();
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setBool("loggedIn", true);
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            "/",
                            (r) => false,
                            arguments: RootArguments(initialLoad: false),
                          );
                        }
                      },
                      child: Text(
                        "SAVE",
                        style: kSmallButtonDarkTextStyle,
                      ),
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(150, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

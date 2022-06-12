import 'package:cloud_firestore/cloud_firestore.dart';

class Profile {
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String name;
  final String bio;
  final List followers;
  final List following;
  final bool isPrivate;

  const Profile(
      {required this.username,
        required this.name,
        required this.uid,
        required this.photoUrl,
        required this.email,
        required this.bio,
        required this.followers,
        required this.following,
        required this.isPrivate});

  static Profile fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Profile(
      username: snapshot["username"],
      name: snapshot["name"],
      uid: snapshot["uid"],
      email: snapshot["email"],
      photoUrl: snapshot["photoUrl"],
      bio: snapshot["bio"],
      followers: snapshot["followers"],
      following: snapshot["following"],
      isPrivate: snapshot["isPrivate"],
    );
  }

  Map<String, dynamic> toJson() => {
    "username": username,
    "name": name,
    "uid": uid,
    "email": email,
    "photoUrl": photoUrl,
    "bio": bio,
    "followers": followers,
    "following": following,
    "isPrivate": isPrivate,
  };

  factory Profile.fromMap(Map<String, dynamic> users) {
    return Profile(
      username: users['username'],
      name: users['name'],
      uid: users['uid'],
      email: users['email'],
      photoUrl: users['photoUrl'],
      bio: users['bio'],
      followers: users['followers'],
      following: users['following'],
      isPrivate: false,

    );
  }
}
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

  const Profile(
      {required this.username,
        required this.name,
        required this.uid,
        required this.photoUrl,
        required this.email,
        required this.bio,
        required this.followers,
        required this.following});

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
    );
  }

  Map<String, dynamic> toJson() => {
    "username": username,
    "namename": name,
    "uid": uid,
    "email": email,
    "photoUrl": photoUrl,
    "bio": bio,
    "followers": followers,
    "following": following,
  };
}
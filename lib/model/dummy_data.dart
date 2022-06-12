import 'package:penta/model/notif.dart';
import 'package:penta/model/comment.dart';
import 'package:penta/model/post.dart';
import 'package:penta/model/user.dart';

//This data will get replaced by firebase in the future
final DUMMY_USERS = [
  Profile(
    uid: "0",
    username: "elonmusk",
    email: "iamelon@gmail.com",
    name: "Elon Musk",
    photoUrl:
        "https://i01.sozcucdn.com/wp-content/uploads/2021/03/11/iecrop/elonmusk-reuters_16_9_1615464321.jpg",
    bio: "Richest Man Alive",
    followers: [],
    following: [],
    isPrivate: false
  ),
];
final DUMMY_NOTIF = [
  Notif(
      userId: 1,
      username: "jeffreyBezos",
      text: "liked your photo",
      date: "1,1,1999",
      commentincl: true,
      postId: 12,
      activityId: 2),
  Notif(
      userId: 2,
      username: "harryP",
      text: "is following you",
      date: "1,1,1212",
      commentincl: false,
      postId: 12,
      activityId: 2),
  Notif(
      userId: 4,
      username: "vfb1",
      text: "commented on your photo",
      date: "1,1,1212",
      commentincl: true,
      postId: 10,
      activityId: 2),
  Notif(
      userId: 1,
      username: "jeffreyBezos",
      text: "sent you message",
      date: "1,1,1212",
      commentincl: false,
      postId: 12,
      activityId: 2),
  Notif(
      userId: 2,
      username: "harryP",
      text: "sent a new post",
      date: "1,1,1212",
      commentincl: true,
      postId: 4,
      activityId: 2),
];

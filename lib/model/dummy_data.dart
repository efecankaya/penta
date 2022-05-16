import 'package:flutter/material.dart';

import 'package:penta/model/comment.dart';
import 'package:penta/model/post.dart';
import 'package:penta/model/user.dart';

final DUMMY_USERS = [
  User(
    id: 0,
    username: "user0",
    email: "user0@gmail.com",
    name: "user0name",
    photo: "https://icon-library.com/images/profile-icon/profile-icon-22.jpg",
    bio: "i like the number 0",
    followers: Map(),
    following: Map(),
  ),
  User(
    id: 1,
    username: "user1",
    email: "user1@gmail.com",
    name: "user1name",
    photo: "https://icon-library.com/images/profile-icon/profile-icon-22.jpg",
    bio: "i like the number 1",
    followers: Map(),
    following: Map(),
  ),
  User(
    id: 2,
    username: "user2",
    email: "user2@gmail.com",
    name: "user2name",
    photo: "https://icon-library.com/images/profile-icon/profile-icon-22.jpg",
    bio: "i like the number 2",
    followers: Map(),
    following: Map(),
  ),
  User(
    id: 3,
    username: "user3",
    email: "user3@gmail.com",
    name: "user3name",
    photo: "https://icon-library.com/images/profile-icon/profile-icon-22.jpg",
    bio: "i like the number 3",
    followers: Map(),
    following: Map(),
  ),
  User(
    id: 4,
    username: "user4",
    email: "user4@gmail.com",
    name: "user4name",
    photo: "https://icon-library.com/images/profile-icon/profile-icon-22.jpg",
    bio: "i like the number 4",
    followers: Map(),
    following: Map(),
  ),
  User(
    id: 5,
    username: "user5",
    email: "user5@gmail.com",
    name: "user5name",
    photo: "https://icon-library.com/images/profile-icon/profile-icon-22.jpg",
    bio: "i like the number 5",
    followers: Map(),
    following: Map(),
  ),
  User(
    id: 6,
    username: "user6",
    email: "user6@gmail.com",
    name: "user6name",
    photo: "https://icon-library.com/images/profile-icon/profile-icon-22.jpg",
    bio: "i like the number 6",
    followers: Map(),
    following: Map(),
  ),
  User(
    id: 7,
    username: "user7",
    email: "user7@gmail.com",
    name: "user7name",
    photo: "https://icon-library.com/images/profile-icon/profile-icon-22.jpg",
    bio: "i like the number 7",
    followers: Map(),
    following: Map(),
  ),
  User(
    id: 8,
    username: "user8",
    email: "user8@gmail.com",
    name: "user8name",
    photo: "https://icon-library.com/images/profile-icon/profile-icon-22.jpg",
    bio: "i like the number 8",
    followers: Map(),
    following: Map(),
  ),
  User(
    id: 9,
    username: "user9",
    email: "user9@gmail.com",
    name: "user9name",
    photo: "https://icon-library.com/images/profile-icon/profile-icon-22.jpg",
    bio: "i like the number 9",
    followers: Map(),
    following: Map(),
  ),
  User(
    id: 10,
    username: "user10",
    email: "user10@gmail.com",
    name: "user10name",
    photo: "https://icon-library.com/images/profile-icon/profile-icon-22.jpg",
    bio: "i like the number 10",
    followers: Map(),
    following: Map(),
  ),
  User(
    id: 11,
    username: "user11",
    email: "user11@gmail.com",
    name: "user11name",
    photo: "https://icon-library.com/images/profile-icon/profile-icon-22.jpg",
    bio: "i like the number 11",
    followers: Map(),
    following: Map(),
  ),
  User(
    id: 12,
    username: "user12",
    email: "user12@gmail.com",
    name: "user12name",
    photo: "https://icon-library.com/images/profile-icon/profile-icon-22.jpg",
    bio: "i like the number 12",
    followers: Map(),
    following: Map(),
  ),
];

final DUMMY_POSTS = [
  Post(
    id: 0,
    username: "user1",
    date: "01/01/2001",
    likes: 10,
    image: "assets/images/0.jpeg",
    location: "Sabanci University",
    description: "Hello! This is a photo that I just took. It looks really cool.",
    comments: [
      Comment(
        userId: 1,
        username: "user1",
        text: "comment1",
        date: "01/01/2001",
        likes: 1,
      ),
    ].toList(),
    topics: ["Nature", "Tree"],
  ),
  Post(
    id: 1,
    username: "user1",
    date: "01/01/2001",
    likes: 10,
    image: "assets/images/1.jpeg",
    location: "Sabanci University",
    description: "Hello! This is a photo that I just took. It looks really cool.",
    comments: [
      Comment(
        userId: 2,
        username: "user2",
        text: "comment2",
        date: "01/01/2001",
        likes: 1,
      ),
    ].toList(),
    topics: ["Nature", "Tree"],
  ),
  Post(
    id: 2,
    username: "user2",
    date: "01/01/2001",
    likes: 20,
    image: "assets/images/2.jpeg",
    location: "Sabanci University",
    description: "Hello! This is a photo that I just took. It looks really cool.",
    comments: [
      Comment(
        userId: 2,
        username: "user2",
        text: "comment2",
        date: "01/01/2001",
        likes: 1,
      ),
      Comment(
        userId: 3,
        username: "user3",
        text: "comment3",
        date: "01/01/2001",
        likes: 1,
      ),
    ].toList(),
    topics: ["Nature", "Tree"],
  ),
  Post(
    id: 3,
    username: "user0",
    date: "01/01/2001",
    likes: 10,
    image: "assets/images/3.jpeg",
    location: "Sabanci University",
    description: "Hello! This is a photo that I just took. It looks really cool.",
    comments: [
      Comment(
        userId: 2,
        username: "user2",
        text: "comment2",
        date: "01/01/2001",
        likes: 1,
      ),
      Comment(
        userId: 4,
        username: "user4",
        text: "comment4",
        date: "01/01/2001",
        likes: 1,
      ),
    ].toList(),
    topics: ["Nature", "Tree"],
  ),
  Post(
    id: 4,
    username: "user0",
    date: "01/01/2001",
    likes: 10,
    image: "assets/images/4.jpeg",
    location: "Sabanci University",
    description: "Hello! This is a photo that I just took. It looks really cool.",
    comments: [
      Comment(
        userId: 2,
        username: "user2",
        text: "comment2",
        date: "01/01/2001",
        likes: 1,
      ),
      Comment(
        userId: 1,
        username: "user1",
        text: "comment1",
        date: "01/01/2001",
        likes: 1,
      ),
      Comment(
        userId: 4,
        username: "user4",
        text: "comment4",
        date: "01/01/2001",
        likes: 1,
      ),
    ].toList(),
    topics: ["Nature", "Tree"],
  ),
  Post(
    id: 5,
    username: "user0",
    date: "01/01/2001",
    likes: 10,
    image: "assets/images/5.jpeg",
    location: "Sabanci University",
    description: "Hello! This is a photo that I just took. It looks really cool.",
    comments: [
      Comment(
        userId: 1,
        username: "user1",
        text: "comment1",
        date: "01/01/2001",
        likes: 1,
      ),
      Comment(
        userId: 4,
        username: "user4",
        text: "comment4",
        date: "01/01/2001",
        likes: 1,
      ),
      Comment(
        userId: 1,
        username: "user1",
        text: "comment1",
        date: "01/01/2001",
        likes: 1,
      ),
      Comment(
        userId: 4,
        username: "user4",
        text: "comment4",
        date: "01/01/2001",
        likes: 1,
      ),
    ].toList(),
    topics: ["Nature", "Tree"],
  ),
  Post(
    id: 6,
    username: "user0",
    date: "01/01/2001",
    likes: 10,
    image: "assets/images/6.jpeg",
    location: "Sabanci University",
    description: "Hello! This is a photo that I just took. It looks really cool.",
    comments: [
      Comment(
        userId: 5,
        username: "user5",
        text: "comment5",
        date: "01/01/2001",
        likes: 1,
      ),
      Comment(
        userId: 4,
        username: "user4",
        text: "comment4",
        date: "01/01/2001",
        likes: 1,
      ),
    ].toList(),
    topics: ["Nature", "Tree"],
  ),
  Post(
    id: 7,
    username: "user7",
    date: "01/01/2001",
    likes: 10,
    image: "assets/images/7.jpeg",
    location: "Sabanci University",
    description: "Hello! This is a photo that I just took. It looks really cool.",
    comments: [
      Comment(
        userId: 1,
        username: "user4",
        text: "comment1",
        date: "01/01/2001",
        likes: 1,
      ),
      Comment(
        userId: 2,
        username: "user2",
        text: "comment2",
        date: "01/01/2001",
        likes: 1,
      ),
    ].toList(),
    topics: ["Nature", "Tree"],
  ),
  Post(
    id: 8,
    username: "user0",
    date: "01/01/2001",
    likes: 10,
    image: "assets/images/8.jpeg",
    location: "Sabanci University",
    description: "Hello! This is a photo that I just took. It looks really cool.",
    comments: [
      Comment(
        userId: 1,
        username: "user1",
        text: "comment1",
        date: "01/01/2001",
        likes: 1,
      ),
      Comment(
        userId: 4,
        username: "user4",
        text: "comment4",
        date: "01/01/2001",
        likes: 1,
      ),
    ].toList(),
    topics: ["Nature", "Tree"],
  ),
  Post(
    id: 9,
    username: "user0",
    date: "01/01/2001",
    likes: 10,
    image: "assets/images/9.jpeg",
    location: "Sabanci University",
    description: "Hello! This is a photo that I just took. It looks really cool.",
    comments: [
      Comment(
        userId: 1,
        username: "user1",
        text: "comment1",
        date: "01/01/2001",
        likes: 1,
      ),
      Comment(
        userId: 4,
        username: "user4",
        text: "comment4",
        date: "01/01/2001",
        likes: 1,
      ),
    ].toList(),
    topics: ["Nature", "Tree"],
  ),
  Post(
    id: 10,
    username: "user0",
    date: "01/01/2001",
    likes: 10,
    image: "assets/images/10.jpeg",
    location: "Sabanci University",
    description: "Hello! This is a photo that I just took. It looks really cool.",
    comments: [
      Comment(
        userId: 1,
        username: "user1",
        text: "comment1",
        date: "01/01/2001",
        likes: 1,
      ),
      Comment(
        userId: 4,
        username: "user4",
        text: "comment4",
        date: "01/01/2001",
        likes: 1,
      ),
    ].toList(),
    topics: ["Nature", "Tree"],
  ),
  Post(
    id: 11,
    username: "user0",
    date: "01/01/2001",
    likes: 10,
    image: "assets/images/11.jpeg",
    location: "Sabanci University",
    description: "Hello! This is a photo that I just took. It looks really cool.",
    comments: [
      Comment(
        userId: 1,
        username: "user1",
        text: "comment1",
        date: "01/01/2001",
        likes: 1,
      ),
      Comment(
        userId: 4,
        username: "user4",
        text: "comment4",
        date: "01/01/2001",
        likes: 1,
      ),
    ].toList(),
    topics: ["Nature", "Tree"],
  ),
  Post(
    id: 12,
    username: "user0",
    date: "01/01/2001",
    likes: 10,
    image: "assets/images/12.jpeg",
    location: "Sabanci University",
    description: "Hello! This is a photo that I just took. It looks really cool.",
    comments: [
      Comment(
        userId: 1,
        username: "user1",
        text: "comment1",
        date: "01/01/2001",
        likes: 1,
      ),
      Comment(
        userId: 4,
        username: "user4",
        text: "comment4",
        date: "01/01/2001",
        likes: 1,
      ),
    ].toList(),
    topics: ["Nature", "Tree"],
  ),
];

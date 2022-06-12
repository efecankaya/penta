import 'package:flutter/material.dart';
import 'package:penta/model/comment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String mediaUrl;
  final String username;
  final String location;
  final String description;
  final int likes;
  final String postId;
  final String ownerId;

  const Post({
    required this.mediaUrl,
    required this.username,
    required this.location,
    required this.description,
    required this.likes,
    required this.postId,
    required this.ownerId,
  });

  factory Post.fromDocument(DocumentSnapshot document) {
    return Post(
      username: document['username'],
      location: document['location'],
      mediaUrl: document['mediaUrl'],
      likes: document['likes'],
      description: document['description'],
      postId: document.id,
      ownerId: document['ownerId'],
    );
  }

  Map<String, dynamic> toJson() => {
    "username": username,
    "location": location,
    "mediaUrl": mediaUrl,
    "likes": likes,
    "description": description,
    "postId": postId,
    "ownerId": ownerId,
  };

  factory Post.fromMap(Map<String, dynamic> posts) {
    return Post(
      username: posts['username'],
      location: posts['location'],
      mediaUrl: posts['mediaUrl'],
      likes: posts['likes'],
      description: posts['description'],
      postId: posts['postId'],
      ownerId: posts['ownerId'],
    );
  }

  factory Post.fromJSON(Map data) {
    return Post(
      username: data['username'],
      location: data['location'],
      mediaUrl: data['mediaUrl'],
      likes: data['likes'],
      description: data['description'],
      ownerId: data['ownerId'],
      postId: data['postId'],
    );
  }

}

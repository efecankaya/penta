import 'package:penta/model/comment.dart';

class Post {
  final int id;
  final String username;
  final String date;
  final int likes;
  final String image;
  final List<Comment> comments;
  final String location;
  final String description;
  final List<String> topics;

  const Post({
    required this.id,
    required this.username,
    required this.date,
    required this.likes,
    required this.image,
    required this.comments,
    required this.location,
    required this.description,
    required this.topics,
  });
}
class Comment {
  final int userId;
  final String username;
  final String text;
  final String date;
  final int likes;

  const Comment({
    required this.userId,
    required this.username,
    required this.text,
    required this.date,
    required this.likes,
  });
}
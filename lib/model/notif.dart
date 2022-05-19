class Notif {
  final int userId;
  final int activityId;
  final int postId;
  final String username;
  final String text;
  final String date;
  final bool commentincl;

  const Notif({
    required this.userId,
    required this.username,
    required this.text,
    required this.date,
    required this.commentincl,
    required this.postId,
    required this.activityId
  });
}

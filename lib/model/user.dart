class User {
  final int id;
  final String username;
  final String email;
  final String name;
  final String photo;
  final String bio;
  final Map followers;
  final Map following;

  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.name,
    required this.photo,
    required this.bio,
    required this.followers,
    required this.following,
  });
}

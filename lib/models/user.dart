class Usermodel {
  const Usermodel({
    required this.email,
    required this.uid,
    required this.username,
    required this.bio,
    required this.profileImage,
    required this.followers,
    required this.following,
  });

  final String email;
  final String uid;
  final String username;
  final String bio;
  final String profileImage;
  final List followers;
  final List following;

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "profileImage": profileImage,
        "bio": bio,
        "followers": followers,
        "following": following,
      };
}

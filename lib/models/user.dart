import 'package:cloud_firestore/cloud_firestore.dart';

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

  static Usermodel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Usermodel(
      email: snapshot["email"],
      uid: snapshot["uid"],
      username: snapshot["username"],
      bio: snapshot["bio"],
      profileImage: snapshot["profileImage"],
      followers: snapshot["followers"],
      following: snapshot["following"],
    );
  }
}

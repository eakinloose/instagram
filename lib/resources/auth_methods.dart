import "dart:typed_data";

// import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:instagram/models/user.dart";
import "package:instagram/resources/storage_methods.dart";

class Authmethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Usermodel> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snapshot =
        await _firestore.collection("users").doc(currentUser.uid).get();

    return Usermodel.fromSnap(snapshot);
  }

  //SIGNUP USER METHOD
  Future<String> signupUser({
    required String email,
    required String username,
    required String password,
    required String bio,
    required Uint8List file,
  }) async {
    String? response;

    try {
      // Check if email already exists
      final emailQuery = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (emailQuery.docs.isNotEmpty) {
        response = 'Email already exists. Please use a different email.';
        return response;
      }

      if (email.isNotEmpty ||
          username.isNotEmpty ||
          password.isNotEmpty ||
          bio.isNotEmpty) {
        //register user
        UserCredential userCredentials =
            await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String photoUrl = await StorageMethods()
            .uploadImageToStorage("profilePics", file, false);

        Usermodel user = Usermodel(
          email: email,
          uid: userCredentials.user!.uid,
          username: username,
          bio: bio,
          profileImage: photoUrl,
          followers: [],
          following: [],
        );

        //add user to our database
        await _firestore
            .collection("users")
            .doc(userCredentials.user!.uid)
            .set(user.toJson());

        response = "success";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == "invalid-email") {
        response = "Email is badly formatted. Please try again";
      } else if (err.code == "weak-password") {
        response =
            "Password should be at least 6 characters long. Please try again";
      }
    } catch (err) {
      response = err.toString();
    }
    return response!;
  }

  //LOGIN USER METHOD
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String? response;

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      response = "success";
    } on FirebaseAuthException catch (err) {
      if (err.code == "user-not-found") {
        response = "Email does not exist";
      } else if (err.code == "wrong-password") {
        response = "Invalid login credentials";
      }
    } catch (err) {
      response = err.toString();
    }
    return response!;
  }
}

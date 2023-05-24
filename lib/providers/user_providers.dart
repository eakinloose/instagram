import 'package:flutter/material.dart';
import 'package:instagram/models/user.dart';
import 'package:instagram/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  Usermodel? _user;
  final Authmethods _authMethods = Authmethods();

  Usermodel get getUser => _user!;

  Future<void> refreshUser() async {
    Usermodel user = await _authMethods.getUserDetails();

    _user = user;
    notifyListeners();
  }
}

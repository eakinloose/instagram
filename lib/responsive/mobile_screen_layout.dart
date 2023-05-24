import 'package:flutter/material.dart';
import 'package:instagram/models/user.dart';
import 'package:instagram/providers/user_providers.dart';
import 'package:provider/provider.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  @override
  Widget build(BuildContext context) {
    Usermodel user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      body: Center(
        child: Text(user.email),

      ),
    );
  }
}

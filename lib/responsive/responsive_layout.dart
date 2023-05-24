import 'package:flutter/material.dart';
import 'package:instagram/providers/user_providers.dart';
import 'package:instagram/utils/dimensions.dart';
import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget {
  const ResponsiveLayout({
    super.key,
    required this.webLayout,
    required this.mobileLayout,
  });

  final Widget webLayout;
  final Widget mobileLayout;

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  void addData() async {
    UserProvider userProvider = Provider.of(context, listen: false);

    await userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webScreenLayout) {
          return widget.webLayout;
        }
        return widget.mobileLayout;
      },
    );
  }
}

import 'package:flutter/material.dart';

class MainSkeleton extends StatelessWidget {
  final Widget body;

  MainSkeleton({this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
    );
  }
}
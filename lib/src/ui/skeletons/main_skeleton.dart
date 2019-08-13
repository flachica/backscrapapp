import 'package:flutter/material.dart';

class MainSkeleton extends StatelessWidget {
  final Widget body;
  final Widget appBar;
  final Widget floatingActionButton;

  MainSkeleton({this.body, this.appBar, this.floatingActionButton});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      appBar: appBar,
      floatingActionButton: floatingActionButton,
    );
  }
}
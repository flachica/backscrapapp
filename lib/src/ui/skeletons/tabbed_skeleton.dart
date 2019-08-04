import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TabbedSkeleton extends StatelessWidget {
  final String title;
  final List<Widget> tabPages;
  final List<Tab> tabBar;

  TabbedSkeleton({this.title, this.tabPages, this.tabBar});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: this.tabPages.length,
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text(title),),
          backgroundColor: Colors.blueAccent,
          bottom: TabBar(
            tabs: tabBar,
          ),
        ),
        body: TabBarView(children: tabPages),
      ),
    );
  }
}
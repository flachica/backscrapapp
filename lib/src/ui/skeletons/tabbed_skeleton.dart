import 'package:flutter/material.dart';

class TabbedSkeleton extends StatelessWidget {
  final String title;
  final List<Widget> tabPages;
  final List<Tab> tabBar;
  final int index;

  TabbedSkeleton({this.title, this.tabPages, this.tabBar, this.index});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: this.index,
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
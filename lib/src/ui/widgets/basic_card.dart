import 'package:flutter/material.dart';

class BasicCard extends StatelessWidget {
  final Widget content;

  BasicCard({this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))
        ),
        elevation: 2,
        margin: EdgeInsets.all(5.0),
        child: content
    );
  }
}
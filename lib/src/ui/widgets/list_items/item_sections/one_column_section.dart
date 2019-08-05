import 'package:flutter/material.dart';

class OneColumnRow extends StatelessWidget {
  final String title;
  final String text;

  OneColumnRow({this.title, this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0, bottom: 5.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(text, maxLines: 10),
          ]),
    );
  }
}

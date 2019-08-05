import 'package:flutter/material.dart';

class TwoColumnSection extends StatelessWidget {
  final String title;
  final String firstText;
  final String secondText;

  TwoColumnSection({this.title, this.firstText, this.secondText});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 15.0, bottom: 5.0, right: 15.0),
            child: Text(title,
              style: TextStyle(fontWeight: FontWeight.bold,),),
          ),
          Padding(
              padding: EdgeInsets.only(left: 15.0, bottom: 5.0, right: 15.0),
              child: Row(
                children: <Widget>[
                  Text(firstText),
                  Spacer(),
                  Text(secondText)
                ],
              )
          ),
        ]
    );
  }
}
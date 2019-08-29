import 'package:flutter/material.dart';

class ConfigIcon extends StatelessWidget {
  final String text;
  final iconData;

  ConfigIcon({this.text, this.iconData});

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Padding(
          padding: EdgeInsets.only(right: 5),
          child: Icon(iconData, color: Colors.blueGrey,)
      ),
      Text(text)],
    );
  }
}
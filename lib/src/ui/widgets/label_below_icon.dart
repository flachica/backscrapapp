import 'package:flutter/material.dart';

class LabelBelowIcon extends StatelessWidget {
  final label;
  final IconData icon;
  final iconColor;
  final onPressed;
  final circleColor;
  final betweenHeight;

  LabelBelowIcon(
      {this.label,
        this.icon,
        this.onPressed,
        this.iconColor = Colors.white,
        this.circleColor,
        this.betweenHeight = 5.0});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            size: 50.0,
            color: iconColor,
          ),
          SizedBox(
            height: betweenHeight,
          ),
          Text(
            label,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
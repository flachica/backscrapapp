import 'package:flutter/material.dart';
import 'package:backscrapapp/src/ui/widgets/label_below_icon.dart';

class IconicGridTwo extends StatelessWidget {
  final firstLabel;
  final IconData firstIcon;
  final firstOnPressed;

  final secondLabel;
  final IconData secondIcon;
  final secondOnPressed;

  const IconicGridTwo({
    Key key,
    this.firstLabel,
    this.firstIcon,
    this.firstOnPressed,
    this.secondLabel,
    this.secondIcon,
    this.secondOnPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox.fromSize(
            size: Size.square(deviceSize.width / 2.5),
            child: Card(
              color: Colors.grey.shade300,
              child: LabelBelowIcon(
                betweenHeight: 15.0,
                icon: firstIcon,
                label: firstLabel,
                iconColor: Colors.indigo.shade800,
                onPressed: firstOnPressed,
              ),
            ),
          ),
          SizedBox.fromSize(
            size: Size.square(deviceSize.width / 2.5),
            child: Card(
              color: Colors.grey.shade300,
              child: LabelBelowIcon(
                betweenHeight: 15.0,
                icon: secondIcon,
                label: secondLabel,
                iconColor: Colors.indigo.shade800,
                onPressed: secondOnPressed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
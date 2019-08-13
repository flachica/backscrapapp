import 'package:flutter/material.dart';
import 'package:backscrapapp/src/ui/widgets/basic_card.dart';

class LabeledImage extends StatelessWidget {
  final String text;
  final String imageURL;
  final deviceSize;
  final Widget bottomWidget;

  LabeledImage({this.text, this.imageURL, this.deviceSize, this.bottomWidget});

  @override
  Widget build(BuildContext context) {
    return BasicCard(
      content: Column(children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 5, left: 10, right: 10),
          child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        SizedBox.fromSize(
            size: Size.fromHeight(deviceSize.height / 2.7),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 15),
              child: Image.asset(
                imageURL,
                width: 100.0,
                height: 100.0,
              ),
            )),
        bottomWidget ?? Container()
      ]),
    );
  }
}

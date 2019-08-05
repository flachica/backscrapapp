import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CenterButtonSection extends StatelessWidget {
  final String link;

  CenterButtonSection({this.link});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Center(
            child: new RaisedButton(
                color: Colors.blueAccent,
                textColor: Colors.white,
                child: new Text('Documento oficial'),
                onPressed: () => launch(link)
            )
        )
    );
  }
}

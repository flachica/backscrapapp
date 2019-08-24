import 'package:flutter/material.dart';
import 'package:backscrapapp/src/ui/skeletons/main_skeleton.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:backscrapapp/src/tools/tools.dart';

class ErrorRoute extends StatelessWidget {
  static const routeName = '/error';
  String error;

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    RouteArguments arguments = ModalRoute.of(context).settings.arguments;
    if (arguments.error != null) error = arguments.error.toString(); else error = '';

    return MainSkeleton(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(1),
                child:
                    Image.asset('img/fer.png', height: deviceSize.height / 3.0),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Le puse',
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 3, right: 3),
                        child: Icon(
                          FontAwesomeIcons.solidHeart,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                  Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: Text('pero falló diciendo: ' + this.error)
                  ),
              RaisedButton(
                child: Text(
                  'Contácteme',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () =>
                    launch('https://flachica.github.io/fernandolachica/'),
                color: Colors.blueAccent,
              )
            ])),
        appBar: AppBar(
          title: Text('Es embarazoso pero . . . '),
        ));
  }
}

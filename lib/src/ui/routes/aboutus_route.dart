import 'package:flutter/material.dart';
import 'package:backscrapapp/src/ui/skeletons/main_skeleton.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:backscrapapp/src/resources/env.dart';


class AboutusRoute extends StatelessWidget {
  static const routeName = '/aboutus';
  Env env;

  AboutusRoute(Env env) {
    this.env = env;
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    this.env.repository.sendAnalyticsEvent('route.$routeName', env.deviceInfo);

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
                        'Hecho con',
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
                      child: Text('por Fernando La Chica')
                  ),
              RaisedButton(
                child: Text(
                  'Perfil web',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () =>
                    launch('https://flachica.github.io/fernandolachica/'),
                color: Colors.blueAccent,
              )
            ])),
        appBar: AppBar(
          title: Text('Acerca de'),
        ));
  }
}

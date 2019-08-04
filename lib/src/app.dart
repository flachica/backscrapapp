import 'package:flutter/material.dart';
import 'package:backscrapapp/src/ui/routes/welcome_route.dart';
import 'package:backscrapapp/src/ui/routes/content_route.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          WelcomeRoute.routeName: (context) => WelcomeRoute(),
          ContentRoute.routeName: (context) => ContentRoute(),
        },
    );
  }
}
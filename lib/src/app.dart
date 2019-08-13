import 'package:flutter/material.dart';
import 'package:backscrapapp/src/ui/routes/initial_route.dart';
import 'package:backscrapapp/src/ui/routes/ilustrating_route.dart';
import 'package:backscrapapp/src/ui/routes/content_route.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          InitialRoute.routeName: (context) => InitialRoute(),
          IlustratingRoute.routeName: (context) => IlustratingRoute(),
          ContentRoute.routeName: (context) => ContentRoute(context),
        },
    );
  }
}

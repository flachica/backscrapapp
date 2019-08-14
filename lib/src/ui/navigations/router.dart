import 'package:flutter/material.dart';
import 'package:backscrapapp/src/ui/routes/initial_route.dart';
import 'package:backscrapapp/src/ui/routes/content_route.dart';
import 'package:backscrapapp/src/ui/routes/ilustrating_route.dart';
import 'package:backscrapapp/src/ui/routes/aboutus_route.dart';
import 'package:backscrapapp/src/tools/metadata.dart';

class Router {
  static final routes = {
    InitialRoute.routeName: (context) => InitialRoute(),
    IlustratingRoute.routeName: (context) => IlustratingRoute(context),
    ContentRoute.routeName: (context) => ContentRoute(context),
    AboutusRoute.routeName: (context) => AboutusRoute(),
  };

  static gotoRoute(BuildContext context, String routeName, RouteArguments args) {
    Navigator.pushReplacementNamed(context, routeName, arguments: args);
  }

  static gotoContent(BuildContext context, RouteArguments args) {
    gotoRoute(context, ContentRoute.routeName, args);
  }

  static gotoIlustrating(BuildContext context, RouteArguments args) {
    gotoRoute(context, IlustratingRoute.routeName, args);
  }

  static gotoAboutus(BuildContext context) {
    Navigator.pushNamed(context, AboutusRoute.routeName);
  }
}
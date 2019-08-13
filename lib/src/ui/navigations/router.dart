import 'package:flutter/material.dart';
import 'package:backscrapapp/src/ui/routes/content_route.dart';
import 'package:backscrapapp/src/tools/metadata.dart';

class Router {
  static gotoRoute(BuildContext context, String routeName, RouteArguments args) {
    Navigator.pushReplacementNamed(context, routeName, arguments: args);
  }

  static gotoContent(BuildContext context, RouteArguments args) {
    gotoRoute(
        context,
        ContentRoute.routeName,
        args
    );
  }

  static gotoIlustrating(BuildContext context) {
    gotoRoute(context, '/ilustrating', null);
  }
}
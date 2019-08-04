import 'package:flutter/material.dart';
import 'package:backscrapapp/src/tools/metadata.dart';

class Navigation {
  static gotoRoute(BuildContext context, String routeName, RouteArguments args) {
    Navigator.pushNamed(context, routeName, arguments: args);
  }
}
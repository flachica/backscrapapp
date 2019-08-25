import 'package:flutter/material.dart';
import 'package:backscrapapp/src/ui/routes/initial_route.dart';
import 'package:backscrapapp/src/ui/routes/ilustrating_route.dart';
import 'package:backscrapapp/src/ui/routes/content_route.dart';
import 'package:backscrapapp/src/ui/routes/aboutus_route.dart';
import 'package:backscrapapp/src/ui/routes/error_route.dart';
import 'package:backscrapapp/src/ui/routes/settings_route.dart';
import 'package:backscrapapp/src/tools/tools.dart';
import 'package:backscrapapp/src/resources/env.dart';


class Router {
  Env env;

  Router({this.env});

  getRoutes() {
    return {
      InitialRoute.routeName: (context) => InitialRoute(this.env),
      IlustratingRoute.routeName: (context) => IlustratingRoute(context, this.env),
      ContentRoute.routeName: (context) => ContentRoute(context, this.env),
      AboutusRoute.routeName: (context) => AboutusRoute(),
      ErrorRoute.routeName: (context) => ErrorRoute(),
      SettingsRoute.routeName: (context) => SettingsRoute(this.env),
    };
  }

  gotoRoute(BuildContext context, String routeName, RouteArguments args) {
    Navigator.pushReplacementNamed(context, routeName, arguments: args);
  }

  gotoContent(BuildContext context, RouteArguments args) {
    gotoRoute(context, ContentRoute.routeName, args);
  }

  gotoIlustrating(BuildContext context, RouteArguments args) {
    gotoRoute(context, IlustratingRoute.routeName, args);
  }

  gotoAboutus(BuildContext context) {
    Navigator.pushNamed(context, AboutusRoute.routeName);
  }

  gotoError(BuildContext context, RouteArguments args) {
    gotoRoute(context, ErrorRoute.routeName, args);
  }

  gotoSettings(BuildContext context) {
    Navigator.pushNamed(context, SettingsRoute.routeName);
  }
}
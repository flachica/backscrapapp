import 'package:flutter/material.dart';
import 'package:backscrapapp/src/ui/navigations/navigation.dart';
import 'package:backscrapapp/src/ui/routes/content_route.dart';
import 'package:backscrapapp/src/models/alldata_model.dart';
import 'package:backscrapapp/src/tools/metadata.dart';

class WelcomeNavigation extends Navigation {
  static firstOnPressed(BuildContext context, AllDataModel data) {
    Navigation.gotoRoute(
        context,
        ContentRoute.routeName,
        new RouteArguments(fromName: 'Contratos', contratantes: data.pestanaContratante)
    );
  }

  static secondOnPressed(BuildContext context, AllDataModel data) {
    Navigation.gotoRoute(
        context,
        ContentRoute.routeName,
        new RouteArguments(fromName: 'Anuncios', anuncios: data.pestanaAnuncios)
    );
  }
}
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RouteArguments {
  final String show;
  final dynamic data;

  RouteArguments({this.show, this.data});
}

class Tools {
  List<Icon> _listContratosIcons = [
    Icon(FontAwesomeIcons.conciergeBell),
    Icon(FontAwesomeIcons.lightbulb),
    Icon(FontAwesomeIcons.fileContract),
    Icon(FontAwesomeIcons.landmark),
    Icon(FontAwesomeIcons.userLock),
    Icon(FontAwesomeIcons.servicestack),
    Icon(FontAwesomeIcons.wrench),
  ];

  List<Icon> _listAnunciosIcons = [
    Icon(FontAwesomeIcons.userCog),
    Icon(FontAwesomeIcons.moneyCheck),
    Icon(FontAwesomeIcons.moneyBillWave),
    Icon(FontAwesomeIcons.newspaper),
  ];

  Icon iconContratoByIndex (int index)  {
    if (index >= _listContratosIcons.length) {
      return Icon(FontAwesomeIcons.fileContract);
    } else {
      return _listContratosIcons[index];
    }
  }

  Icon iconAnuncioByIndex (int index) {
    if (index >= _listAnunciosIcons.length) {
      return Icon(FontAwesomeIcons.newspaper);
    } else {
      return _listAnunciosIcons[index];
    }
  }

}
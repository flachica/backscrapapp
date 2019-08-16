import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const String CONTRATANTE_SHOW = 'contratante';
const String ANUNCIOS_SHOW = 'anuncios';
const String PRODUCTION_API_URL = 'https://backscrap.herokuapp.com/';
const String DEVELOPMENT_API_URL = 'http://192.168.1.131:8000/';
const String DEVICE_URL_SUFIX = 'devices/';
const String SCRAPED_URL_SUFIX = 'scraped/';
const bool IS_PRODUCTION = bool.fromEnvironment('dart.vm.product');

class RouteArguments {
  final String show;
  final dynamic data;

  RouteArguments({this.show, this.data});
}

class Tools {
  static String getApiURL() {
    if (IS_PRODUCTION) {
      return PRODUCTION_API_URL;
    } else {
      return DEVELOPMENT_API_URL;
    }
  }

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
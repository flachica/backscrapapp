import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:backscrapapp/src/resources/env.dart';

const String CONTRATANTE_SHOW = 'contratante';
const String ANUNCIOS_SHOW = 'anuncios';
const String DEVICE_URL_SUFIX = 'devices/';
const String DEVICE_UNREGISTER_URL_SUFIX = 'fcmmanagement/?action=delete&device=';
const String SCRAPED_URL_SUFIX = 'scraped/';
const String ILUSTRATING_VIEWED = 'ilustratingViewed';
const String LAST_ANUNCIO_REMOTE_CALLED = 'larc';
const String LAST_CONTRATO_REMOTE_CALLED = 'lcrc';
const String BE_NOTIFIED = 'bn';

class RouteArguments {
  final String show;
  final dynamic data;
  final Env env;
  final dynamic pushMessage;
  final dynamic error;

  RouteArguments({this.show, this.data, this.env, this.pushMessage, this.error});
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

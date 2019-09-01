import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:backscrapapp/src/resources/env.dart';
import 'package:catcher/catcher_plugin.dart';

const String PUBLICCONTRACTS_SHOW = 'publiccontract';
const String EDICTS_SHOW = 'edicts';
const String DEVICE_URL_SUFIX = 'devices/';
const String DEVICE_UNREGISTER_URL_SUFIX =
    'fcmmanagement/?action=delete&device=';
const String SCRAPED_URL_SUFIX = 'scraped/';
const String ERROR_HANDLER_URL_SUFIX = 'error/';
const String ILUSTRATING_VIEWED = 'ilustratingViewed';
const String LAST_EDICT_REMOTE_CALLED = 'lerc';
const String LAST_PUBLICCONTRACT_REMOTE_CALLED = 'lpcrc';
const String BE_NOTIFIED = 'bn';

class RouteArguments {
  final String show;
  final dynamic data;
  final Env env;
  final dynamic pushMessage;
  final dynamic error;

  RouteArguments(
      {this.show, this.data, this.env, this.pushMessage, this.error});
}

class Tools {
  List<Icon> _listPublicContractsIcons = [
    Icon(FontAwesomeIcons.conciergeBell),
    Icon(FontAwesomeIcons.lightbulb),
    Icon(FontAwesomeIcons.fileContract),
    Icon(FontAwesomeIcons.landmark),
    Icon(FontAwesomeIcons.userLock),
    Icon(FontAwesomeIcons.servicestack),
    Icon(FontAwesomeIcons.wrench),
  ];

  List<Icon> _listEdictsIcons = [
    Icon(FontAwesomeIcons.userCog),
    Icon(FontAwesomeIcons.moneyCheck),
    Icon(FontAwesomeIcons.moneyBillWave),
    Icon(FontAwesomeIcons.newspaper),
  ];

  Icon iconPublicContractByIndex(int index) {
    if (index >= _listPublicContractsIcons.length) {
      return Icon(FontAwesomeIcons.fileContract);
    } else {
      return _listPublicContractsIcons[index];
    }
  }

  Icon iconEdictByIndex(int index) {
    if (index >= _listEdictsIcons.length) {
      return Icon(FontAwesomeIcons.newspaper);
    } else {
      return _listEdictsIcons[index];
    }
  }

  static LocalizationOptions getLocalizationOptions() {
    return LocalizationOptions("es",
        notificationReportModeTitle: "Error de aplicación",
        notificationReportModeContent:
            "Haga clic aquí para enviar un informe de error al equipo de soporte.",
        dialogReportModeTitle: "Error",
        dialogReportModeDescription:
            "Se ha producido un error inesperado en la aplicación. El informe de errores está listo para enviar al equipo de soporte. Haga clic en Aceptar para enviar el informe de errores o en Cancelar para cancelar el informe.",
        dialogReportModeAccept: "Aceptar",
        dialogReportModeCancel: "Cancelar",
        pageReportModeTitle: "Error",
        pageReportModeDescription:
            "Se ha producido un error inesperado en la aplicación. El informe de errores está listo para enviar al equipo de soporte. Haga clic en Aceptar para enviar el informe de errores o en Cancelar para cancelar el informe.",
        pageReportModeAccept: "Aceptar",
        pageReportModeCancel: "Cancelar");
  }
}

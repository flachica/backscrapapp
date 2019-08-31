import 'dart:async';
import 'package:backscrapapp/src/resources/data_provider.dart';
import 'package:backscrapapp/src/models/alldata_model.dart';
import 'package:backscrapapp/src/resources/env.dart';
import 'package:backscrapapp/src/tools/tools.dart';
import 'package:firebase_analytics/firebase_analytics.dart';


class Repository {
  String apiURL;
  DataProvider dataProvider;
  FirebaseAnalytics analytics;

  Repository(Env env) {
    this.apiURL = env.apiURL;
    this.dataProvider = DataProvider(apiURL: this.apiURL, env: env);
    this.analytics = env.analytics;
  }

  Future<AllDataModel> getAllData() => dataProvider.getAllData();
  Future<dynamic> postData(String url, dynamic data) => dataProvider.postData(url, data);
  Future<dynamic> getData(String url) => dataProvider.getData(url);
  Future<bool> getIlustratingViewed() => dataProvider.getIlustratingViewed();
  Future<void> setLastAnuncio(int anuncio) => dataProvider.setLastAnuncio(anuncio);
  Future<void> setLastContrato(int contrato) => dataProvider.setLastContrato(contrato);
  Future<void> deleteUnreadedAnuncio(int anuncio) => dataProvider.deleteUnreadedAnuncio(anuncio);
  Future<void> deleteUnreadedContrato(int contrato) => dataProvider.deleteUnreadedContrato(contrato);
  Future<void> deleteAllUnreadedAnuncio() => dataProvider.deleteAllUnreadedAnuncio();
  Future<void> deleteAllUnreadedContrato() => dataProvider.deleteAllUnreadedContrato();
  Future<bool> getBeNotified() => dataProvider.getBeNotified();
  Future<void> setBeNotified(bool beNotified) => dataProvider.setBeNotified(beNotified);
  Future<dynamic> registerOnBackend(String token) async {
    Map<String, String> data = {
      'name': token,
      'registration_id': token,
      'type': 'android'
    };
    return this.postData(DEVICE_URL_SUFIX, data);
  }
  Future<dynamic> unRegisterOnBackend(String token) async {
    return this.getData(DEVICE_UNREGISTER_URL_SUFIX + token);
  }
  Future<void> sendAnalyticsEvent(String eventName, Map<String, dynamic> params) async {
    eventName = eventName.replaceAll('.', '_');
    eventName = eventName.replaceAll('/', '_');
    await analytics.logEvent(
      name: eventName,
      parameters: params,
    );
    print('Evento $eventName con parametros $params enviado.');
  }
}
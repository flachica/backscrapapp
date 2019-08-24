import 'dart:async';
import 'package:backscrapapp/src/resources/data_provider.dart';
import 'package:backscrapapp/src/models/alldata_model.dart';
import 'package:backscrapapp/src/resources/env.dart';

class Repository {
  String apiURL;
  DataProvider dataProvider;

  Repository(Env env) {
    this.apiURL = env.apiURL;
    this.dataProvider = DataProvider(apiURL: this.apiURL, env: env);
  }

  Future<AllDataModel> getAllData() => dataProvider.getAllData();
  Future<dynamic> postData(String url, dynamic data) => dataProvider.postData(url, data);
  Future<bool> getIlustratingViewed() => dataProvider.getIlustratingViewed();
  Future<void> setLastAnuncio(int anuncio) => dataProvider.setLastAnuncio(anuncio);
  Future<void> setLastContrato(int contrato) => dataProvider.setLastContrato(contrato);
  Future<void> deleteUnreadedAnuncio(int anuncio) => dataProvider.deleteUnreadedAnuncio(anuncio);
  Future<void> deleteUnreadedContrato(int contrato) => dataProvider.deleteUnreadedContrato(contrato);
}
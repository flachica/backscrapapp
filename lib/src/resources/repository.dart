import 'dart:async';
import 'package:backscrapapp/src/resources/api_provider.dart';
import 'package:backscrapapp/src/models/alldata_model.dart';

class Repository {
  String apiURL;
  ApiProvider apiProvider;

  Repository(String apiURL) {
    this.apiURL = apiURL;
    this.apiProvider = ApiProvider(apiURL: this.apiURL);
  }

  Future<AllDataModel> getAllData() => apiProvider.getAllData();
  Future<dynamic> postData(String url, dynamic data) => apiProvider.postData(url, data);
}
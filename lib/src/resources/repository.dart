import 'dart:async';
import 'package:backscrapapp/src/resources/api_provider.dart';
import 'package:backscrapapp/src/models/alldata_model.dart';

class Repository {
  final apiProvider = ApiProvider();

  Future<AllDataModel> getAllData() => apiProvider.getAllData();
  Future<dynamic> postData(String url, dynamic data) => apiProvider.postData(url, data);
}
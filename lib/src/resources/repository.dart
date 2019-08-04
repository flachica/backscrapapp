import 'dart:async';
import 'api_provider.dart';
import '../models/alldata_model.dart';

class Repository {
  final apiProvider = ApiProvider();

  Future<AllDataModel> getAllData() => apiProvider.getAllData();
}
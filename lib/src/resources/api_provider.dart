import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/alldata_model.dart';

class ApiProvider {
  Client client = Client();
  final _api_url = 'https://backscrap.herokuapp.com/scraped/';

  Future<AllDataModel> getAllData() async {
    final response = await client.get(_api_url);
    if (response.statusCode == 200) {
      return AllDataModel.fromJSON(json.decode(response.body)['result']);
    } else {
      throw Exception('Error al cargar datos desde Internet');
    }
  }
}
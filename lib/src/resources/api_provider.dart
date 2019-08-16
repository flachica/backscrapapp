import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'package:backscrapapp/src/models/alldata_model.dart';
import 'package:backscrapapp/src/tools/tools.dart';

class ApiProvider {
  Client client = Client();

  Future<AllDataModel> getAllData() async {
    final response = await client.get(Tools.getApiURL() + SCRAPED_URL_SUFIX);
    if (response.statusCode == 200) {
      return AllDataModel.fromJSON(json.decode(response.body)['result']);
    } else {
      throw Exception('Error al cargar datos desde Internet');
    }
  }

  Future<dynamic> postData(String url, dynamic data) async {
    return client.post(Tools.getApiURL() + url, body: data).then((res) {
      Map<String, dynamic> result = {
        'statusCode': res.statusCode,
        'reasonPhrase': res.reasonPhrase,
        'body': json.decode(res.body)
      };
      return result;
    });

  }
}
import 'dart:async';
import 'package:backscrapapp/src/models/unreadedanuncios_model.dart';
import 'package:backscrapapp/src/models/unreadedcontratos_model.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'package:backscrapapp/src/models/alldata_model.dart';
import 'package:backscrapapp/src/tools/tools.dart';
import 'package:backscrapapp/src/resources/env.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class DataProvider {
  String apiURL;
  Env env;

  DataProvider({this.apiURL, this.env});
  Client client = Client();

  Future<AllDataModel> getAllData() async {
    final response = await client.get(this.apiURL + SCRAPED_URL_SUFIX);
    final List<int> unreadedAnuncios = await this.getUnreadedAnuncios();
    final List<int> unreadedContratos = await this.getUnreadedContratos();
    int lastAnuncioRemoteCalled = await this.getLastAnuncio();
    int lastContratoRemoteCalled = await this.getLastContrato();

    if (response.statusCode == 200) {
      var parsedJSON = json.decode(response.body)['result'];
      var _lastAnuncio = parsedJSON['uanuncio'];
      var _lastContrato = parsedJSON['ucontratantes'];

      if (lastAnuncioRemoteCalled != null && lastAnuncioRemoteCalled != 0) {
        for (var i = lastAnuncioRemoteCalled + 1; i < _lastAnuncio; i += 1) {
          unreadedAnuncios.add(i);
        }
        for (var i = lastContratoRemoteCalled + 1; i < _lastContrato; i += 1) {
          unreadedContratos.add(i);
        }
      }
      await this.insertUnreadedAnuncios(unreadedAnuncios);
      await this.insertUnreadedContratos(unreadedContratos);
      return AllDataModel.fromJSON(
          parsedJSON,
          unreadedAnuncios,
          unreadedContratos,
      );
    } else {
      throw Exception('Error al cargar datos desde Internet');
    }
  }

  Future<dynamic> postData(String url, dynamic data) async {
    return client.post(this.apiURL + url, body: data).then((res) {
      Map<String, dynamic> result = {
        'statusCode': res.statusCode,
        'reasonPhrase': res.reasonPhrase,
        'body': json.decode(res.body)
      };
      return result;
    });

  }

  Future<List<int>> getUnreadedAnuncios() async {
    final Database db = await this.env.getDatabase();
    List<Map<String, dynamic>> maps = await db.query(UnReadedAnuncios.model);

    return List.generate(maps.length, (i) {
      return maps[i]['id'];
    });
  }

  Future<List<int>> getUnreadedContratos() async {
    final Database db = await this.env.getDatabase();
    List<Map<String, dynamic>> maps = await db.query(UnReadedContratos.model);

    return List.generate(maps.length, (i) {
      return maps[i]['id'];
    });
  }

  Future<void> insertUnreadedAnuncios(List<int> anuncios) async {
    final Database db = await this.env.getDatabase();

    for (int anuncio in anuncios) {
      await db.insert(
        UnReadedAnuncios.model,
        {'id': anuncio},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<void> insertUnreadedContratos(List<int> contratos) async {
    final Database db = await this.env.getDatabase();

    for (int contrato in contratos) {
      await db.insert(
        UnReadedContratos.model,
        {'id': contrato},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<void> deleteUnreadedAnuncio(int id) async {
    final Database db = await this.env.getDatabase();

    await db.delete(
      UnReadedAnuncios.model,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> deleteUnreadedContrato(int id) async {
    final Database db = await this.env.getDatabase();

    await db.delete(
      UnReadedContratos.model,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<bool> getIlustratingViewed() async {
    final SharedPreferences prefs = await this.env.getPreferencesManager();
    return (prefs.getBool(ILUSTRATING_VIEWED) ?? false);
  }

  Future<int> getLastAnuncio() async {
    final SharedPreferences prefs = await this.env.getPreferencesManager();
    return (prefs.getInt(LAST_ANUNCIO_REMOTE_CALLED) ?? 0);
  }

  Future<int> getLastContrato() async {
    final SharedPreferences prefs = await this.env.getPreferencesManager();
    return (prefs.getInt(LAST_CONTRATO_REMOTE_CALLED) ?? 0);
  }

  Future<void> setLastAnuncio(int anuncio) async {
    final SharedPreferences prefs = await this.env.getPreferencesManager();
    prefs.setInt(LAST_ANUNCIO_REMOTE_CALLED, anuncio);
  }

  Future<void> setLastContrato(int contrato) async {
    final SharedPreferences prefs = await this.env.getPreferencesManager();
    prefs.setInt(LAST_CONTRATO_REMOTE_CALLED, contrato);
  }
}
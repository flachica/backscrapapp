import 'dart:async';
import 'dart:convert';
import 'package:backscrapapp/src/models/edictunreaded_model.dart';
import 'package:backscrapapp/src/models/publiccontractunreaded_model.dart';
import 'package:http/http.dart' show Client;
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
    final List<int> unreadedEdicts = await this.getUnreadedEdicts();
    final List<int> unreadedPublicContracts =
        await this.getUnreadedPublicContracts();

    int lastEdictRemoteCalled = await this.getLastEdict();
    int lastPublicContractRemoteCalled = await this.getLastPublicContract();
    print('Edicts unreaded before: ' + unreadedEdicts.toString());
    print('PublicContracts unreaded before: ' +
        unreadedPublicContracts.toString());
    print(
        'Edict local $lastEdictRemoteCalled PublicContract local $lastPublicContractRemoteCalled');

    if (response.statusCode == 200) {
      var parsedJSON = json.decode(response.body)['result'];
      var _lastEdict = parsedJSON['ledict'];
      var _lastPublicContract = parsedJSON['lpubliccontract'];
      await this.setLastEdict(_lastEdict);
      await this.setLastPublicContract(_lastPublicContract);
      print(
          'Remote Edict $_lastEdict Remote PublicContract $_lastPublicContract');
      if (lastEdictRemoteCalled != null && lastEdictRemoteCalled != 0) {
        for (var i = lastEdictRemoteCalled + 1; i <= _lastEdict; i += 1) {
          unreadedEdicts.add(i);
        }
        for (var i = lastPublicContractRemoteCalled + 1;
            i <= _lastPublicContract;
            i += 1) {
          unreadedPublicContracts.add(i);
        }
        await this.insertUnreadedEdicts(unreadedEdicts);
        await this.insertUnreadedPublicContracts(unreadedPublicContracts);
      }

      var result = AllDataModel.fromJSON(
        parsedJSON,
        unreadedEdicts,
        unreadedPublicContracts,
      );
      print('Edicts unreaded final: ' + unreadedEdicts.toString());
      print('PublicContracts unreaded final: ' +
          unreadedPublicContracts.toString());
      return result;
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

  Future<dynamic> getData(String url) async {
    return client.get(this.apiURL + url);
  }

  Future<List<int>> getUnreadedEdicts() async {
    final Database db = await this.env.getDatabase();
    List<Map<String, dynamic>> maps = await db.query(UnReadedEdicts.model);

    return List.generate(maps.length, (i) {
      return maps[i]['id'];
    });
  }

  Future<List<int>> getUnreadedPublicContracts() async {
    final Database db = await this.env.getDatabase();
    List<Map<String, dynamic>> maps =
        await db.query(UnReadedPublicContracts.model);

    return List.generate(maps.length, (i) {
      return maps[i]['id'];
    });
  }

  Future<void> insertUnreadedEdicts(List<int> edicts) async {
    final Database db = await this.env.getDatabase();

    for (int edict in edicts) {
      await db.insert(
        UnReadedEdicts.model,
        {'id': edict},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<void> insertUnreadedPublicContracts(List<int> publicContracts) async {
    final Database db = await this.env.getDatabase();

    for (int publicContract in publicContracts) {
      await db.insert(
        UnReadedPublicContracts.model,
        {'id': publicContract},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<void> deleteUnreadedEdict(int id) async {
    final Database db = await this.env.getDatabase();

    await db.delete(
      UnReadedEdicts.model,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> deleteUnreadedPublicContract(int id) async {
    final Database db = await this.env.getDatabase();

    await db.delete(
      UnReadedPublicContracts.model,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> deleteAllUnreadedEdict() async {
    final Database db = await this.env.getDatabase();
    await db.delete(UnReadedEdicts.model);
  }

  Future<void> deleteAllUnreadedPublicContract() async {
    final Database db = await this.env.getDatabase();
    await db.delete(UnReadedPublicContracts.model);
  }

  Future<bool> getIlustratingViewed() async {
    final SharedPreferences prefs = await this.env.getPreferencesManager();
    return (prefs.getBool(ILUSTRATING_VIEWED) ?? false);
  }

  Future<int> getLastEdict() async {
    final SharedPreferences prefs = await this.env.getPreferencesManager();
    return (prefs.getInt(LAST_EDICT_REMOTE_CALLED) ?? 0);
  }

  Future<int> getLastPublicContract() async {
    final SharedPreferences prefs = await this.env.getPreferencesManager();
    return (prefs.getInt(LAST_PUBLICCONTRACT_REMOTE_CALLED) ?? 0);
  }

  Future<void> setLastEdict(int edict) async {
    final SharedPreferences prefs = await this.env.getPreferencesManager();
    prefs.setInt(LAST_EDICT_REMOTE_CALLED, edict);
  }

  Future<void> setLastPublicContract(int publicContract) async {
    final SharedPreferences prefs = await this.env.getPreferencesManager();
    prefs.setInt(LAST_PUBLICCONTRACT_REMOTE_CALLED, publicContract);
  }

  Future<bool> getBeNotified() async {
    final SharedPreferences prefs = await this.env.getPreferencesManager();
    return prefs.getBool(BE_NOTIFIED);
  }

  Future<void> setBeNotified(bool beNotified) async {
    final SharedPreferences prefs = await this.env.getPreferencesManager();
    prefs.setBool(BE_NOTIFIED, beNotified);
  }
}

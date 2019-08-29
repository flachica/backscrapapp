import 'package:backscrapapp/src/app.dart';
import 'package:backscrapapp/src/resources/repository.dart';
import 'package:backscrapapp/config/router.dart';
import 'package:backscrapapp/src/tools/tools.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:catcher/catcher_plugin.dart';

class Env {
  static Env value;

  String apiURL;
  Repository repository;
  Router router;
  Function(Map<String, dynamic>) onMessage;
  Function(Map<String, dynamic>) onResume;
  dynamic pendingReadpush;
  int local_uanuncio;
  int local_ucontrato;
  Future<Database> _database;
  SharedPreferences prefs;
  FirebaseMessaging firebaseMessaging;
  String token;

  Env() {
    value = this;
    this.router = Router(env: this);
    this.repository = Repository(this);

    ReportMode reportMode = PageReportMode(
        showStackTrace: false,
    );

    LocalizationOptions lo = Tools.getLocalizationOptions();
    CatcherOptions debugOptions = CatcherOptions(
        reportMode,
        [ConsoleHandler(),
          HttpHandler(
            HttpRequestType.post,
            Uri.parse(this.apiURL + ERROR_HANDLER_URL_SUFIX),
            printLogs: true,

          )],
      localizationOptions: [lo]
    );

    Catcher(App(env: this), debugConfig: debugOptions);
    //runApp(App(env: this));
  }

  Future<Database> getDatabase() async {
    if (this._database == null) {
      this._database = openDatabase(
        join(await getDatabasesPath(), 'backscrapapp_database.db'),
        onCreate: (db, version) {
          db.execute(
            "CREATE TABLE unreaded_anuncios (id INTEGER PRIMARY KEY)",
          );
          db.execute(
            "CREATE TABLE unreaded_contratos (id INTEGER PRIMARY KEY)",
          );
        },
        version: 1,
      );
    }
    return this._database;
  }

  Future<SharedPreferences> getPreferencesManager() async {
    if (this.prefs == null) {
      SharedPreferences result = await SharedPreferences.getInstance();
      return result;
    } else {
      return this.prefs;
    }
  }

  String get name => runtimeType.toString();
}
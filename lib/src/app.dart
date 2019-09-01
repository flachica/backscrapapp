import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:backscrapapp/src/resources/env.dart';
import 'package:catcher/catcher_plugin.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:device_info/device_info.dart';

class App extends StatefulWidget {
  final Env env;

  App({this.env});

  @override
  AppState createState() => new AppState();
}

class AppState extends State<App> {

  @override
  void initState() {
    String url = widget.env.apiURL;
    print('INIT. URL: $url');
    super.initState();
    widget.env.firebaseMessaging = new FirebaseMessaging();
    widget.env.firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('FCM.onMessage message: $message');
        return widget.env.onMessage(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print('FCM.onResume message: $message');
        widget.env.onResume(message);
        return;
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('FCM.onLaunch message: $message');
        // Este evento sucede antes de pintar el primer frame en la App
        // Por eso en el InitState hay que consultar esta variable
        widget.env.pendingReadpush = message;
        return;
      },
    );

    widget.env.firebaseMessaging.getToken().then((token) {
      print('FCM Init with token: $token');
      widget.env.token = token;
      widget.env.repository.registerOnBackend(token);
    });

    _loadAsyncSettings();
  }

  _loadAsyncSettings() async {
    bool _beNotifiedEdicts = await widget.env.repository.getBeNotified();
    if (_beNotifiedEdicts == null) {
      await widget.env.repository.setBeNotified(true);
      _beNotifiedEdicts = true;
    }
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    widget.env.androidInfo = await deviceInfo.androidInfo;
    widget.env.deviceInfo = <String, dynamic>{
      'manufacturer': widget.env.androidInfo.manufacturer,
      'model': widget.env.androidInfo.model,
      'android': 'Android ' + widget.env.androidInfo.version.release + ' SDK ' + widget.env.androidInfo.version.sdkInt.toString() + ' PATCH ' + widget.env.androidInfo.version.securityPatch,
    };
    widget.env.repository.sendAnalyticsEvent('initialized', widget.env.deviceInfo);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: Catcher.navigatorKey,
        routes: widget.env.router.getRoutes(),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('es'),
        ]
    );
  }
}

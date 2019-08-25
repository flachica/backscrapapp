import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:backscrapapp/src/resources/env.dart';

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
    print('Inicialización. URL: $url');
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
      print('FCM Inicializado con el token: $token');
      widget.env.token = token;
      widget.env.repository.registerOnBackend(token);
    });

    _loadFCMSettings();
  }

  _loadFCMSettings() async {
    bool _beNotifiedAnuncios = await widget.env.repository.getBeNotified();
    if (_beNotifiedAnuncios == null) {
      await widget.env.repository.setBeNotified(true);
      _beNotifiedAnuncios = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: widget.env.router.getRoutes(),
    );
  }
}

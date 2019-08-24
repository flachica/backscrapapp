import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:backscrapapp/src/tools/tools.dart';
import 'package:backscrapapp/src/resources/env.dart';

class App extends StatefulWidget {
  final Env env;

  App({this.env});

  @override
  AppState createState() => new AppState();
}

class AppState extends State<App> {
  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

  Future<dynamic> _registerOnBackend(String token) async {
    Map<String, String> data = {
      'name': token,
      'registration_id': token,
      'type': 'android'
    };
    return widget.env.repository.postData(DEVICE_URL_SUFIX, data);
  }

  @override
  void initState() {
    String url = widget.env.apiURL;
    print('Inicialización. URL: $url');
    super.initState();

    _firebaseMessaging.configure(
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

    _firebaseMessaging.getToken().then((token){
      print('FCM Inicializado con el token: $token');
      _registerOnBackend(token).then((dynamic response) {
        print('Backscrap response: $response');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: widget.env.router.getRoutes(),
    );
  }
}

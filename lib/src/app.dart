import 'package:flutter/material.dart';
import 'package:backscrapapp/src/ui/navigations/router.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:backscrapapp/src/resources/repository.dart';
import 'package:backscrapapp/src/tools/tools.dart';

class App extends StatefulWidget {
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
    return Repository().postData(DEVICE_URL_SUFIX, data);
  }

  @override
  void initState() {
    print('Inicialización');
    super.initState();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) {
        print('FCM.onMessage message: $message');
        return;
      },
      onResume: (Map<String, dynamic> message) {
        print('FCM.onResume message: $message');
        return;
      },
      onLaunch: (Map<String, dynamic> message) {
        print('FCM.onLaunch message: $message');
        return;
      },
    );

    _firebaseMessaging.getToken().then((token){
      _registerOnBackend(token).then((dynamic response) {
        print('Backscrap response: $response');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: Router.routes,
    );
  }
}

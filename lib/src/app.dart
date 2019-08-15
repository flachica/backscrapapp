import 'package:flutter/material.dart';
import 'package:backscrapapp/src/ui/navigations/router.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class App extends StatefulWidget {
  @override
  AppState createState() => new AppState();
}

class AppState extends State<App> {
  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

  @override
  void initState() {
    print('Inicialización');
    super.initState();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) {
        print('on message $message');
        return;
      },
      onResume: (Map<String, dynamic> message) {
        print('on resume $message');
        return;
      },
      onLaunch: (Map<String, dynamic> message) {
        print('on launch $message');
        return;
      },
    );

    _firebaseMessaging.getToken().then((token){
      print(token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: Router.routes,
    );
  }
}

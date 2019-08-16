import 'package:flutter/material.dart';
import 'package:backscrapapp/src/app.dart';
import 'package:backscrapapp/src/resources/repository.dart';
import 'package:backscrapapp/config/router.dart';

class Env {
  static Env value;

  String apiURL;
  Repository repository;
  Router router;

  Env() {
    value = this;
    repository = Repository(this.apiURL);
    router = Router(env: this);
    runApp(App(env: this));
  }

  String get name => runtimeType.toString();
}
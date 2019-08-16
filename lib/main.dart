import 'package:flutter/material.dart';
import 'package:backscrapapp/src/app.dart';
import 'package:backscrapapp/src/resources/env.dart';
import 'package:backscrapapp/config/api_from_remote.dart';

Env env = ApiFromRemote();

void main() => runApp(App(env: env,));
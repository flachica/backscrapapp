import 'package:flutter/material.dart';
import 'package:backscrapapp/src/ui/navigations/router.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: Router.routes,
    );
  }
}

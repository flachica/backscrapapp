import 'package:flutter/material.dart';
import 'package:backscrapapp/src/tools/tools.dart';
import 'package:backscrapapp/src/resources/env.dart';

class DrawerApp extends StatelessWidget {
  dynamic data;
  Env env;

  DrawerApp({this.data, this.env});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Backscrapp', style: TextStyle(color: Colors.white),),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
              title: Text('Contratos'),
              onTap: () {
                Navigator.pop(context);
                this.env.router.gotoContent(context, RouteArguments(show: CONTRATANTE_SHOW, data: this.data));
              }),
          ListTile(
              title: Text('Anuncios'),
              onTap: () {
                Navigator.pop(context);
                this.env.router.gotoContent(context, RouteArguments(show: ANUNCIOS_SHOW, data: this.data));
              }),
          ListTile(
              title: Text('Ver intro'),
              onTap: () {
                Navigator.pop(context);
                this.env.router.gotoIlustrating(context, RouteArguments(data: this.data));
              }),
          ListTile(
              title: Text('Acerca de'),
              onTap: () {
                Navigator.pop(context);
                this.env.router.gotoAboutus(context);
              }),
        ],
      ),
    );
  }
}
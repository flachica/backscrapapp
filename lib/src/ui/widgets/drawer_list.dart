import 'package:flutter/material.dart';
import 'package:backscrapapp/src/tools/tools.dart';
import 'package:backscrapapp/src/ui/navigations/router.dart';

class DrawerApp extends StatelessWidget {
  dynamic data;

  DrawerApp({this.data});

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
                Router.gotoContent(context, RouteArguments(show: CONTRATANTE_SHOW, data: this.data));
              }),
          ListTile(
              title: Text('Anuncios'),
              onTap: () {
                Navigator.pop(context);
                Router.gotoContent(context, RouteArguments(show: ANUNCIOS_SHOW, data: this.data));
              }),
          ListTile(
              title: Text('Ver intro'),
              onTap: () {
                Navigator.pop(context);
                Router.gotoIlustrating(context, RouteArguments(data: this.data));
              }),
          ListTile(
              title: Text('Acerca de'),
              onTap: () {
                Navigator.pop(context);
                Router.gotoAboutus(context);
              }),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Backscrapp', style: TextStyle(color: Colors.white),),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Row(
              children: <Widget>[
                Icon(FontAwesomeIcons.fileContract, color: Colors.blueAccent,),
                Padding(padding: EdgeInsets.only(left: 10), child: Text('Contratos'),)
              ],
            ),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Row(
              children: <Widget>[
                Icon(FontAwesomeIcons.newspaper, color: Colors.blueAccent,),
                Padding(padding: EdgeInsets.only(left: 10), child: Text('Anuncios'),)
              ],
            ),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
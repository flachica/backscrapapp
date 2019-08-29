import 'package:flutter/material.dart';
import 'package:backscrapapp/src/tools/tools.dart';
import 'package:backscrapapp/src/resources/env.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:backscrapapp/src/ui/widgets/config_icon.dart';
import 'package:catcher/catcher_plugin.dart';

class DrawerApp extends StatelessWidget {
  dynamic data;
  Env env;

  DrawerApp({this.data, this.env});

  @override
  Widget build(BuildContext context) {
    Widget debugingWidget;
    if (this.env.withDebuggingOptions) {
      debugingWidget = ListTile(
            title: ConfigIcon(
                text: 'Enviar error',
                iconData: FontAwesomeIcons.blackberry
            ),
            onTap: () {
              Navigator.pop(context);
              Catcher.sendTestException();
            });
    }
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
              title: ConfigIcon(
                  text: 'Contratos',
                  iconData: FontAwesomeIcons.fileContract
              ),
              onTap: () {
                Navigator.pop(context);
                this.env.router.gotoContent(context, RouteArguments(show: CONTRATANTE_SHOW, data: this.data));
              }),
          ListTile(
              title: ConfigIcon(
                  text: 'Anuncios',
                  iconData: FontAwesomeIcons.newspaper
              ),
              onTap: () {
                Navigator.pop(context);
                this.env.router.gotoContent(context, RouteArguments(show: ANUNCIOS_SHOW, data: this.data));
              }),
          ListTile(
              title: ConfigIcon(
                  text: 'Configuración',
                  iconData: FontAwesomeIcons.cog
              ),
              onTap: () {
                Navigator.pop(context);
                this.env.router.gotoSettings(context);
              }),
          ListTile(
              title: ConfigIcon(
                  text: 'Ver intro',
                  iconData: FontAwesomeIcons.ticketAlt
              ),
              onTap: () {
                Navigator.pop(context);
                this.env.router.gotoIlustrating(context, RouteArguments(data: this.data));
              }),
          ListTile(
              title: ConfigIcon(
                  text: 'Acerca de',
                  iconData: FontAwesomeIcons.userCircle),
              onTap: () {
                Navigator.pop(context);
                this.env.router.gotoAboutus(context);
              }),
          debugingWidget
        ],
      ),
    );
  }
}
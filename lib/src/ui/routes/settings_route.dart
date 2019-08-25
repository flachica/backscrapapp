import 'package:flutter/material.dart';
import 'package:backscrapapp/src/ui/skeletons/main_skeleton.dart';
import 'package:backscrapapp/src/resources/env.dart';
import 'package:backscrapapp/src/tools/tools.dart';

class SettingsRoute extends StatefulWidget {
  static const routeName = '/settings';
  Env env;

  SettingsRoute(Env env) {
    this.env = env;
  }

  @override
  State<StatefulWidget> createState() {
    return SettingsState();
  }
}

class SettingsState extends State<SettingsRoute> {
  bool _beNotified;

  @override
  void initState() {
    super.initState();
    _loadBeNotified();
  }

  _loadBeNotified() async {
    _beNotified = await widget.env.repository.getBeNotified();
    print('Be notified $_beNotified');
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> contentWidget = [CircularProgressIndicator()];
    String title = 'Cargando configuración . . .';
    if (_beNotified != null) {
      contentWidget = [
        Padding(
          padding: EdgeInsets.only(left: 30, right: 30),
          child: Row(
            children: <Widget>[
              Text('Recibir notificaciones'),
              Spacer(),
              Switch(
                  value: _beNotified,
                  onChanged: (bool value) {
                    setState(() {
                      widget.env.repository.setBeNotified(value);
                      if (value) widget.env.repository.registerOnBackend(widget.env.token);
                      else widget.env.repository.unRegisterOnBackend(widget.env.token);
                      _beNotified = value;
                    });
                  }
              )
            ],
          ),
        )
      ];
      title ='Configuración';
    }
    Widget titleWidget = Text(title);
    return MainSkeleton(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: contentWidget,
          ),
        ),
        appBar: AppBar(
          title: titleWidget
        )
    );
  }
}

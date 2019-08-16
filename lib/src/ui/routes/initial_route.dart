import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:backscrapapp/src/models/alldata_model.dart';
import 'package:backscrapapp/src/ui/skeletons/main_skeleton.dart';
import 'package:backscrapapp/src/tools/tools.dart';
import 'package:backscrapapp/src/resources/env.dart';

class InitialRoute extends StatefulWidget {
  static const routeName = '/';
  Env env;

  InitialRoute(Env env) {
    this.env = env;
  }

  @override
  State<StatefulWidget> createState() {
    return InitialState();
  }
}

class InitialState extends State<InitialRoute> {
  bool _ilustratingViewed = false;

  @override
  void initState() {
    super.initState();
    _loadIlustratingViewed();
  }

  _loadIlustratingViewed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _ilustratingViewed = (prefs.getBool(ILUSTRATING_VIEWED) ?? false);
      if (!_ilustratingViewed) {
        widget.env.router.gotoIlustrating(context, null);
      } else {
        _loadAndShowContent();
      }
    });
  }

  _loadAndShowContent() async {
    AllDataModel data = await widget.env.repository.getAllData();
    widget.env..router.gotoContent(
        context,
        RouteArguments(show: CONTRATANTE_SHOW, data: data)
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainSkeleton(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('Cargando . . .'),
        )
    );
  }
}

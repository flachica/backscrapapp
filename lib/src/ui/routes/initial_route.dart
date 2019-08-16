import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:backscrapapp/src/ui/navigations/router.dart';
import 'package:backscrapapp/src/models/alldata_model.dart';
import 'package:backscrapapp/src/resources/repository.dart';
import 'package:backscrapapp/src/ui/skeletons/main_skeleton.dart';
import 'package:backscrapapp/src/tools/tools.dart';

class InitialRoute extends StatefulWidget {
  static const routeName = '/';

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
      _ilustratingViewed = (prefs.getBool('ilustratingViewed') ?? false);
      if (!_ilustratingViewed) {
        Router.gotoIlustrating(context, null);
      } else {
        _loadAndShowContent();
      }
    });
  }

  _loadAndShowContent() async {
    AllDataModel data = await Repository().getAllData();
    Router.gotoContent(
        context,
        RouteArguments(show: 'contratante', data: data)
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

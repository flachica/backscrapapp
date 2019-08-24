import 'package:flutter/material.dart';
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
  AllDataModel data;

  @override
  void initState() {
    super.initState();
    _loadIlustratingViewed();
  }

  _loadIlustratingViewed() async {
    _ilustratingViewed = await widget.env.repository.getIlustratingViewed();
    setState(() {
      if (!_ilustratingViewed) {
        widget.env.router.gotoIlustrating(context, null);
      } else {
        _loadAndShowContent();
      }
    });
  }

  _loadAndShowContent() async {
    this.data = await widget.env.repository.getAllData();
    await widget.env.repository.setLastAnuncio(this.data.lastAnuncio);
    await widget.env.repository.setLastContrato(this.data.lastContrato);
    widget.env.router.gotoContent(
        context,
        RouteArguments(
            show: CONTRATANTE_SHOW,
            data: this.data
        )
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

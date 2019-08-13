import 'package:flutter/material.dart';
import 'package:backscrapapp/src/ui/skeletons/main_skeleton.dart';
import 'package:backscrapapp/src/blocs/data_bloc.dart';
import 'package:backscrapapp/src/models/alldata_model.dart';
import 'package:backscrapapp/src/ui/widgets/labeled_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:backscrapapp/src/ui/navigations/router.dart';
import 'package:backscrapapp/src/tools/metadata.dart';

class IlustratingRoute extends StatefulWidget {
  static const routeName = '/ilustrating';

  @override
  State<StatefulWidget> createState() {
    return IlustratingState();
  }
}

class IlustratingState extends State<IlustratingRoute> {
  @override
  void initState() {
    super.initState();
    bloc.fetchPestanaAnuncios();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  StreamBuilder<AllDataModel> streamBuilder = StreamBuilder(
      stream: bloc.fetchAllData,
      builder: (context, AsyncSnapshot<AllDataModel> snapshot) {
        bool loading = true;

        if (snapshot.hasData) {
          loading = false;
        }

        return DefaultTabController(
          length: 3,
          child: IlustratingPager(loading: loading, data: snapshot.data),
        );
      });

  @override
  Widget build(BuildContext context) {
    return MainSkeleton(
      body: streamBuilder,
      appBar: AppBar(
        title: Text('Backscrap'),
      )
    );
  }
}

class IlustratingPager extends StatefulWidget {
  bool loading;
  dynamic data;

  IlustratingPager({this.loading, this.data});

  @override
  State<StatefulWidget> createState() {
    return _IlustratingPagerState();
  }
}

class _IlustratingPagerState extends State<IlustratingPager> {
  void _handleArrowButtonPress(BuildContext context, int delta) {
    final TabController controller = DefaultTabController.of(context);
    if (!controller.indexIsChanging)
      controller.animateTo((controller.index + delta).clamp(0, 6));
  }

  _setIlustratingViewed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('ilustratingViewed', true);
      Router.gotoContent(context, RouteArguments(show: 'contratante', data: widget.data));
    });
  }

  @override
  Widget build(BuildContext context) {
    final TabController controller = DefaultTabController.of(context);
    final Color color = Theme.of(context).accentColor;
    Size deviceSize = MediaQuery.of(context).size;

    Widget loadingWidget = LinearProgressIndicator();
    Widget bottomWidget = CircularProgressIndicator();
    if (widget.loading != null && !widget.loading) {
      loadingWidget = Container();
      bottomWidget = Padding(padding: EdgeInsets.only(top: 20),
        child: Center(
          child: RaisedButton(
            color: Theme.of(context).accentColor,
            onPressed: _setIlustratingViewed,
            child: Text('Ir a la App', style: TextStyle(color: Colors.white),),
          ),
        ),
      );
    }
    return SafeArea(
      top: false,
      bottom: false,
      child: Column(
        children: <Widget>[
          loadingWidget,
          Expanded(
            child: IconTheme(
                data: IconThemeData(
                  size: 128.0,
                  color: color,
                ),
                child: TabBarView(children: <Widget>[
                  LabeledImage(
                    text: 'En La Rinconada hay información útil',
                    imageURL: 'img/city.png',
                    deviceSize: deviceSize
                  ),
                  LabeledImage(
                    text: 'Si eres empresa, asociación o para uso personal',
                    imageURL: 'img/ong.png',
                    deviceSize: deviceSize
                  ),
                  LabeledImage(
                      text: 'Fácil de consultar y en el momento',
                      imageURL: 'img/justintime.png',
                      deviceSize: deviceSize,
                      bottomWidget: bottomWidget
                  ),
                ])
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 16.0),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  color: color,
                  onPressed: () {
                    _handleArrowButtonPress(context, -1);
                  },
                  tooltip: 'Page back',
                ),
                TabPageSelector(controller: controller),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  color: color,
                  onPressed: () {
                    _handleArrowButtonPress(context, 1);
                  },
                  tooltip: 'Page forward',
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ),
        ],
      ),
    );
  }
}

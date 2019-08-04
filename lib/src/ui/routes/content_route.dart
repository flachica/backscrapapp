import 'package:flutter/material.dart';
import 'package:backscrapapp/src/ui/skeletons/tabbed_skeleton.dart';
import 'package:backscrapapp/src/tools/metadata.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContentRoute extends StatelessWidget {
  static const routeName = '/content';

  @override
  Widget build(BuildContext context) {
    final RouteArguments arguments = ModalRoute.of(context).settings.arguments;
    int v = arguments.data.pestanaContratante.length;
    if (arguments.fromName == 'Second') {
      v = arguments.data.pestanaAnuncios.length;
    }
    String str = 'Pestañas a pintar $v';

    return TabbedSkeleton(
      title: 'La Rinconada',
      tabBar: <Tab>[
        Tab(icon: Icon(FontAwesomeIcons.fileContract), text: 'Contratos'),
        Tab(icon: Icon(FontAwesomeIcons.newspaper), text: 'Anuncios')
      ],
      tabPages: <Widget>[
        ListView.builder(
          itemCount: arguments.data.pestanaContratante.length,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))
              ),
              elevation: 2,
              margin: EdgeInsets.all(5.0),
              child: Text(arguments.data.pestanaContratante[index].nombre),
            );
          }
        ),
        ListView.builder(
            itemCount: arguments.data.pestanaAnuncios.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(arguments.data.pestanaAnuncios[index].nombre),
              );
            }
        ),
      ],
    );
  }
}

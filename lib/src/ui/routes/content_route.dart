import 'package:flutter/material.dart';
import 'package:backscrapapp/src/ui/skeletons/tabbed_skeleton.dart';
import 'package:backscrapapp/src/tools/metadata.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:backscrapapp/src/ui/widgets/list_items/contrato_item.dart';
import 'package:backscrapapp/src/ui/widgets/list_items/anuncio_item.dart';

class ContentRoute extends StatelessWidget {
  static const routeName = '/content';

  @override
  Widget build(BuildContext context) {
    final RouteArguments arguments = ModalRoute.of(context).settings.arguments;
    int index = 0;
    if (arguments.fromName == 'Anuncios') {
      index = 1;
    }

    return TabbedSkeleton(
      index: index,
      title: 'La Rinconada',
      tabBar: <Tab>[
        Tab(icon: Icon(FontAwesomeIcons.fileContract), text: 'Contratos'),
        Tab(icon: Icon(FontAwesomeIcons.newspaper), text: 'Anuncios')
      ],
      tabPages: <Widget>[
        ListView.builder(
          itemCount: arguments.data.contratos.length,
          itemBuilder: (context, index) {
            return ContratoItem(contrato: arguments.data.contratos[index]);
          }
        ),
        ListView.builder(
            itemCount: arguments.data.anuncios.length,
            itemBuilder: (context, index) {
              return AnuncioItem(anuncio: arguments.data.anuncios[index],);
            }
        ),
      ],
    );
  }
}

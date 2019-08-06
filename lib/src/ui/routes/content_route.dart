import 'package:flutter/material.dart';
import 'package:backscrapapp/src/tools/metadata.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:backscrapapp/src/ui/widgets/list_items/contrato_item.dart';
import 'package:backscrapapp/src/ui/widgets/list_items/anuncio_item.dart';

class ContentRoute extends StatefulWidget {
  static const routeName = '/content';
  int index;
  dynamic data;

  ContentRoute(BuildContext context) {
    RouteArguments arguments = ModalRoute.of(context).settings.arguments;
    data = arguments.data;
    this.index = 0;
    if (arguments.fromName == 'Anuncios') {
      index = 1;
    }
  }

  @override
  ContentRouteState createState() => new ContentRouteState();
}

class ContentRouteState extends State<ContentRoute> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      initialIndex: widget.index,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('La Rinconada'),),
          backgroundColor: Colors.blueAccent,
          bottom: TabBar(
            tabs: <Tab>[
              Tab(icon: Icon(FontAwesomeIcons.fileContract), text: 'Contratos'),
              Tab(icon: Icon(FontAwesomeIcons.newspaper), text: 'Anuncios')
            ],
          ),
        ),
        body: TabBarView(
            children: <Widget>[
              ListView.builder(
                  itemCount: widget.data.contratos.length,
                  itemBuilder: (context, index) {
                    return ContratoItem(contrato: widget.data.contratos[index]);
                  }
              ),
              ListView.builder(
                  itemCount: widget.data.anuncios.length,
                  itemBuilder: (context, index) {
                    return AnuncioItem(anuncio: widget.data.anuncios[index],);
                  }
              ),
            ]
        ),
      ),
    );
  }
}

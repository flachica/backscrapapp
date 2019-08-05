import 'package:flutter/material.dart';
import 'package:backscrapapp/src/models/anuncio_model.dart';
import 'package:backscrapapp/src/ui/widgets/list_items/item_sections/two_column_section.dart';
import 'package:backscrapapp/src/ui/widgets/list_items/item_sections/one_column_section.dart';
import 'package:url_launcher/url_launcher.dart';

class AnuncioItem extends StatelessWidget {
  final Anuncio anuncio;

  AnuncioItem({this.anuncio});

  @override
  Widget build(BuildContext context) {
    return new ExpansionTile(
        backgroundColor: Colors.white,
        title: Text(anuncio.name),
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TwoColumnRow(title: 'Fecha', firstText: anuncio.fecha_desde, secondText: anuncio.fecha_hasta,),
              OneColumnRow(title: 'Tipo', text: anuncio.pestana,),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Center(
                      child: new RaisedButton(
                          color: Colors.blueAccent,
                          textColor: Colors.white,
                          child: new Text('Documento oficial'),
                          onPressed: () => launch(anuncio.link)
                      )
                  )
              )
            ],
          )
        ]);
  }
}

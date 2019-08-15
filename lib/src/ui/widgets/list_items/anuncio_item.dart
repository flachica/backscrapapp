import 'package:flutter/material.dart';
import 'package:backscrapapp/src/models/anuncio_model.dart';
import 'package:backscrapapp/src/ui/widgets/list_items/item_sections/two_column_section.dart';
import 'package:backscrapapp/src/ui/widgets/list_items/item_sections/one_column_section.dart';
import 'package:backscrapapp/src/ui/widgets/list_items/item_sections/center_button_section.dart';

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
              OneColumnSection(title: 'Identificador', text: anuncio.identificador,),
              OneColumnSection(title: 'Contenido', text: anuncio.contenido,),
              TwoColumnSection(title: 'Fecha', firstText: anuncio.fecha_desde, secondText: anuncio.fecha_hasta,),
              OneColumnSection(title: 'Tipo', text: anuncio.pestana,),
              CenterButtonSection(link: anuncio.link,)
            ],
          )
        ]);
  }
}

import 'package:flutter/material.dart';
import 'package:backscrapapp/src/models/anuncio_model.dart';
import 'package:backscrapapp/src/ui/widgets/list_items/item_sections/two_column_section.dart';
import 'package:backscrapapp/src/ui/widgets/list_items/item_sections/one_column_section.dart';
import 'package:backscrapapp/src/ui/widgets/list_items/item_sections/center_button_section.dart';
import 'package:badges/badges.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class AnuncioItem extends StatelessWidget {
  final Anuncio anuncio;
  final onExpansionChanged;

  AnuncioItem({this.anuncio, this.onExpansionChanged});

  @override
  Widget build(BuildContext context) {
    Widget titleWidget = Text(anuncio.name);
    if (this.anuncio.unreaded) {
      titleWidget = Badge(
        badgeColor: Colors.red,
        shape: BadgeShape.square,
        borderRadius: 20,
        toAnimate: false,
        badgeContent:
            Padding(
              padding: EdgeInsets.all(2),
              child: Icon(
                FontAwesomeIcons.exclamation,
                color: Colors.white,
                size: 10,
              ),
            ),
        child: Text(anuncio.name),
      );
    }

    return new ExpansionTile(
        backgroundColor: Colors.white,
        title: titleWidget,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              OneColumnSection(title: 'Identificador', text: anuncio.identificador),
              OneColumnSection(title: 'Contenido', text: anuncio.contenido,),
              TwoColumnSection(title: 'Fecha', firstText: anuncio.fecha_desde, secondText: anuncio.fecha_hasta,),
              OneColumnSection(title: 'Tipo', text: anuncio.pestana,),
              CenterButtonSection(link: anuncio.link,)
            ],
          )
        ],
      onExpansionChanged: onExpansionChanged,
    );
  }
}

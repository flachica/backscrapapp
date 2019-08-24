import 'package:flutter/material.dart';
import 'package:backscrapapp/src/models/contrato_model.dart';
import 'package:backscrapapp/src/ui/widgets/list_items/item_sections/two_column_section.dart';
import 'package:backscrapapp/src/ui/widgets/list_items/item_sections/one_column_section.dart';
import 'package:backscrapapp/src/ui/widgets/list_items/item_sections/center_button_section.dart';
import 'package:badges/badges.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class ContratoItem extends StatelessWidget {
  final Contrato contrato;
  final onExpansionChanged;

  ContratoItem({this.contrato, this.onExpansionChanged});

  @override
  Widget build(BuildContext context) {
    Widget titleWidget = Text(contrato.name);
    if (this.contrato.unreaded) {
      var icon = RotatedBox(
        quarterTurns: 3,
        child: Icon(
          FontAwesomeIcons.tag,
          color: Colors.grey,
          size: 20,
        ),
      );
      titleWidget = Badge(
        badgeColor: Colors.transparent,
        borderRadius: 20,
        elevation: 0,
        badgeContent: icon,
        child: Padding(
          padding: EdgeInsets.only(right: 15),
          child: Text(contrato.name),
        ),
      );
    }
    return ExpansionTile(
        backgroundColor: Colors.white,
        title: titleWidget,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              OneColumnSection(title: 'Identificador', text: contrato.identificador,),
              TwoColumnSection(title: 'Fecha', firstText: contrato.fecha_hasta, secondText: contrato.procedimiento,),
              TwoColumnSection(title: 'Expediente', firstText: contrato.expediente, secondText: contrato.estadoexpediente,),
              OneColumnSection(title: 'Descripción', text: contrato.descripcion,),
              OneColumnSection(title: 'Precio', text: contrato.precio,),
              OneColumnSection(title: 'Tipo', text: contrato.type,),
              CenterButtonSection(link: contrato.link,)
            ],
          )
        ],
      onExpansionChanged: onExpansionChanged,
    );
  }
}

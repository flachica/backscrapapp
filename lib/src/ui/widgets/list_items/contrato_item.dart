import 'package:flutter/material.dart';
import 'package:backscrapapp/src/models/contrato_model.dart';
import 'package:backscrapapp/src/ui/widgets/list_items/item_sections/two_column_section.dart';
import 'package:backscrapapp/src/ui/widgets/list_items/item_sections/one_column_section.dart';
import 'package:backscrapapp/src/ui/widgets/list_items/item_sections/center_button_section.dart';

class ContratoItem extends StatelessWidget {
  final Contrato contrato;

  ContratoItem({this.contrato});

  @override
  Widget build(BuildContext context) {
    return new ExpansionTile(
        backgroundColor: Colors.white,
        title: Text(contrato.name),
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              OneColumnSection(title: 'Fecha', text: contrato.fecha_hasta,),
              TwoColumnSection(title: 'Expediente', firstText: contrato.expediente, secondText: contrato.estadoexpediente,),
              OneColumnSection(title: 'Descripción', text: contrato.descripcion,),
              OneColumnSection(title: 'Precio', text: contrato.precio,),
              OneColumnSection(title: 'Tipo', text: contrato.type,),
              CenterButtonSection(link: contrato.link,)
            ],
          )
        ]);
  }
}

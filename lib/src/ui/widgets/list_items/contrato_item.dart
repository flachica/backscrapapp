import 'package:flutter/material.dart';
import 'package:backscrapapp/src/models/contrato_model.dart';
import 'package:backscrapapp/src/ui/widgets/list_items/item_sections/two_column_section.dart';
import 'package:backscrapapp/src/ui/widgets/list_items/item_sections/one_column_section.dart';
import 'package:url_launcher/url_launcher.dart';

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
              OneColumnRow(title: 'Fecha', text: contrato.fecha_hasta,),
              TwoColumnRow(title: 'Expediente', firstText: contrato.expediente, secondText: contrato.estadoexpediente,),
              OneColumnRow(title: 'Descripción', text: contrato.descripcion,),
              OneColumnRow(title: 'Precio', text: contrato.precio,),
              OneColumnRow(title: 'Tipo', text: contrato.type,),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Center(
                      child: new RaisedButton(
                          color: Colors.blueAccent,
                          textColor: Colors.white,
                          child: new Text('Documento oficial'),
                          onPressed: () => launch(contrato.link)
                      )
                  )
              )
            ],
          )
        ]);
  }
}

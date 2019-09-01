import 'package:flutter/material.dart';
import 'package:backscrapapp/src/models/publiccontract_model.dart';
import 'package:backscrapapp/src/ui/widgets/list_items/item_sections/two_column_section.dart';
import 'package:backscrapapp/src/ui/widgets/list_items/item_sections/one_column_section.dart';
import 'package:backscrapapp/src/ui/widgets/list_items/item_sections/center_button_section.dart';
import 'package:badges/badges.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class PublicContractItem extends StatelessWidget {
  final PublicContract publicContract;
  final onExpansionChanged;

  PublicContractItem({this.publicContract, this.onExpansionChanged});

  @override
  Widget build(BuildContext context) {
    Widget titleWidget = Text(publicContract.name);
    if (this.publicContract.unreaded) {
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
          child: Text(publicContract.name),
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
              OneColumnSection(title: 'hash', text: publicContract.hash,),
              TwoColumnSection(title: 'Fecha', firstText: publicContract.date_to, secondText: publicContract.procedure,),
              TwoColumnSection(title: 'Expediente', firstText: publicContract.contract_record, secondText: publicContract.status_record,),
              OneColumnSection(title: 'Descripción', text: publicContract.description,),
              OneColumnSection(title: 'Precio', text: publicContract.price,),
              OneColumnSection(title: 'Tipo', text: publicContract.type,),
              CenterButtonSection(link: publicContract.link,)
            ],
          )
        ],
      onExpansionChanged: onExpansionChanged,
    );
  }
}

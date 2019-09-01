import 'package:flutter/material.dart';
import 'package:backscrapapp/src/models/edict_model.dart';
import 'package:backscrapapp/src/ui/widgets/list_items/item_sections/two_column_section.dart';
import 'package:backscrapapp/src/ui/widgets/list_items/item_sections/one_column_section.dart';
import 'package:backscrapapp/src/ui/widgets/list_items/item_sections/center_button_section.dart';
import 'package:badges/badges.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class EdictItem extends StatelessWidget {
  final Edict edict;
  final onExpansionChanged;

  EdictItem({this.edict, this.onExpansionChanged});

  @override
  Widget build(BuildContext context) {
    Widget titleWidget = Text(edict.name);
    if (this.edict.unreaded) {
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
        child: Text(edict.name),
      );
    }

    return new ExpansionTile(
        backgroundColor: Colors.white,
        title: titleWidget,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              OneColumnSection(title: 'hash', text: edict.hash),
              OneColumnSection(title: 'content', text: edict.content,),
              TwoColumnSection(title: 'Fecha', firstText: edict.date_from, secondText: edict.date_to,),
              OneColumnSection(title: 'Tipo', text: edict.type,),
              CenterButtonSection(link: edict.link,)
            ],
          )
        ],
      onExpansionChanged: onExpansionChanged,
    );
  }
}

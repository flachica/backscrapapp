import 'package:flutter/material.dart';
import 'package:backscrapapp/src/models/pestanacontratante_model.dart';
import 'package:backscrapapp/src/models/pestanaanuncio_model.dart';
import 'package:backscrapapp/src/tools/metadata.dart';

class DrawerApp extends StatelessWidget {
  List<PestanaContratante> contratantes;
  List<PestanaAnuncios> anuncios;
  Tools tools = new Tools();
  int index = 0;
  DrawerApp({this.contratantes, this.anuncios});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Backscrapp', style: TextStyle(color: Colors.white),),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(children: <Widget>[Padding(padding: EdgeInsets.only(left: 10), child: Text('Contratos', style: TextStyle(fontSize: 16),),)],),
                    InkWell(child: Row(children: <Widget>[tools.iconContratoByIndex(0), Padding(padding: EdgeInsets.only(left: 10, bottom: 10), child: Text('Servicios', style: TextStyle(fontSize: 12)),)],), onTap: () => this.index = 2,),
                    InkWell(child: Row(children: <Widget>[tools.iconContratoByIndex(1), Padding(padding: EdgeInsets.only(left: 10, bottom: 10), child: Text('Suministros', style: TextStyle(fontSize: 12)),)],), onTap: () => Navigator.pop(context),),
                    InkWell(child: Row(children: <Widget>[tools.iconContratoByIndex(2), Padding(padding: EdgeInsets.only(left: 10, bottom: 10), child: Text('Contratos Menores', style: TextStyle(fontSize: 12)),)],), onTap: () => print('Servicios'),),
                    InkWell(child: Row(children: <Widget>[tools.iconContratoByIndex(3), Padding(padding: EdgeInsets.only(left: 10, bottom: 10), child: Text('Contratos Patrimoniales', style: TextStyle(fontSize: 12)),)],), onTap: () => print('Servicios'),),
                    InkWell(child: Row(children: <Widget>[tools.iconContratoByIndex(4), Padding(padding: EdgeInsets.only(left: 10, bottom: 10), child: Text('Convenios y contratos privados', style: TextStyle(fontSize: 12)),)],), onTap: () => print('Servicios'),),
                    InkWell(child: Row(children: <Widget>[tools.iconContratoByIndex(5), Padding(padding: EdgeInsets.only(left: 10, bottom: 10), child: Text('Gestión de Servicios', style: TextStyle(fontSize: 12)),)],), onTap: () => print('Servicios'),),
                    InkWell(child: Row(children: <Widget>[tools.iconContratoByIndex(6), Padding(padding: EdgeInsets.only(left: 10, bottom: 10), child: Text('Obras', style: TextStyle(fontSize: 12)),)],), onTap: () => print('Servicios'),),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            title: Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(children: <Widget>[Padding(padding: EdgeInsets.only(left: 10, top: 20), child: Text('Anuncios', style: TextStyle(fontSize: 16),),)],),
                    Row(children: <Widget>[tools.iconAnuncioByIndex(0), Padding(padding: EdgeInsets.only(left: 10, bottom: 10), child: Text('Procesos Selectivos', style: TextStyle(fontSize: 12)),)],),
                    Row(children: <Widget>[tools.iconAnuncioByIndex(1), Padding(padding: EdgeInsets.only(left: 10, bottom: 10), child: Text('Subvenciones', style: TextStyle(fontSize: 12)),)],),
                    Row(children: <Widget>[tools.iconAnuncioByIndex(2), Padding(padding: EdgeInsets.only(left: 10, bottom: 10), child: Text('Becas', style: TextStyle(fontSize: 12)),)],),
                    Row(children: <Widget>[tools.iconAnuncioByIndex(3), Padding(padding: EdgeInsets.only(left: 10, bottom: 10), child: Text('Anuncios', style: TextStyle(fontSize: 12)),)],),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:backscrapapp/src/tools/metadata.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:backscrapapp/src/ui/widgets/list_items/contrato_item.dart';
import 'package:backscrapapp/src/ui/widgets/list_items/anuncio_item.dart';
import 'package:backscrapapp/src/models/alldata_model.dart';
import 'package:backscrapapp/src/models/anuncio_model.dart';
import 'package:backscrapapp/src/models/contrato_model.dart';

class ContentRoute extends StatefulWidget {
  static const routeName = '/content';
  int index;
  AllDataModel data;

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

  bool _isSearching = false;

  TextEditingController _searchQuery;
  List<Anuncio> anuncios;
  List<Contrato> contratos;

  @override
  void initState() {
    _searchQuery = new TextEditingController();
    this.anuncios = widget.data.anuncios;
    this.contratos = widget.data.contratos;
    super.initState();
  }

  Widget _buildSearchField() {
    return new TextField(
      controller: _searchQuery,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: 'Criterio de búsqueda...',
        border: InputBorder.none,
        hintStyle: const TextStyle(color: Colors.white30),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: updateSearchQuery,
    );
  }

  void updateSearchQuery(String newQuery) {
    //TODO: En el manual no se filtra el mismo modelo de datos que este
    //DE: https://github.com/DeveloperLibs/flutter_list_filter/blob/master/lib/home.dart
    this.anuncios = widget.data.anuncios.where((anuncio) => anuncio.name.toUpperCase().contains(newQuery.toUpperCase())).toList();
    this.contratos = widget.data.contratos.where((contrato) => contrato.name.toUpperCase().contains(newQuery.toUpperCase())).toList();

    setState(() {});
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQuery.clear();
      updateSearchQuery('');
    });
  }


  Widget _buildTitle(BuildContext context) {
    var horizontalTitleAlignment = CrossAxisAlignment.start;

    return new InkWell(
      child: new Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: horizontalTitleAlignment,
          children: <Widget>[
            new Text('La Rinconada',
              style: new TextStyle(color: Colors.white),),
          ],
        ),
      ),
    );
  }

  void _startSearch() {
    ModalRoute.of(context)
        .addLocalHistoryEntry(new LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  List<Widget> _buildActions() {
    if (_isSearching == true) {
      return <Widget>[
        new IconButton(
          icon: const Icon(Icons.clear,color: Colors.white,),
          onPressed: () {
            _clearSearchQuery();
            Navigator.pop(context);
          },
        ),
      ];
    }

    return <Widget>[
      new IconButton(
        icon: const Icon(Icons.search,color: Colors.white,),
        onPressed: _startSearch,
      ),
    ];
  }


  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      initialIndex: widget.index,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: _isSearching ? new BackButton( color: Colors.white,) : null,
          title: _isSearching ? _buildSearchField() : _buildTitle(context),
          actions: _buildActions(),
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
                  itemCount: this.contratos.length,
                  itemBuilder: (context, index) {
                    return ContratoItem(contrato: this.contratos[index]);
                  }
              ),
              ListView.builder(
                  itemCount: this.anuncios.length,
                  itemBuilder: (context, index) {
                    return AnuncioItem(anuncio: this.anuncios[index],);
                  }
              ),
            ]
        ),
      ),
    );
  }
}

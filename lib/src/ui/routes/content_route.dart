import 'package:flutter/material.dart';
import 'package:backscrapapp/src/tools/metadata.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:backscrapapp/src/ui/widgets/list_items/contrato_item.dart';
import 'package:backscrapapp/src/ui/widgets/list_items/anuncio_item.dart';
import 'package:backscrapapp/src/models/pestanacontratante_model.dart';
import 'package:backscrapapp/src/models/pestanaanuncio_model.dart';
import 'package:backscrapapp/src/models/contrato_model.dart';
import 'package:backscrapapp/src/models/anuncio_model.dart';
import 'package:backscrapapp/src/ui/widgets/drawer_list.dart';

class ContentRoute extends StatefulWidget {
  static const routeName = '/content';
  List<PestanaContratante> contratantes;
  List<PestanaAnuncios> anuncios;

  ContentRoute(BuildContext context) {
    RouteArguments arguments = ModalRoute.of(context).settings.arguments;
    contratantes = arguments.contratantes;
    anuncios = arguments.anuncios;
  }

  @override
  ContentRouteState createState() => new ContentRouteState();
}

class ContentRouteState extends State<ContentRoute> {
  bool _isSearching = false;

  TextEditingController _searchQuery;
  List<PestanaContratante> contratantes;
  List<PestanaAnuncios> anuncios;

  @override
  void initState() {
    _searchQuery = new TextEditingController();
    this.contratantes = widget.contratantes;
    this.anuncios = widget.anuncios;
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
    if (widget.contratantes != null) {
      this.contratantes = new List<PestanaContratante>();
      for (PestanaContratante pestanaContrato in widget.contratantes) {
        List<Contrato> items = pestanaContrato.contratos.where((contrato) =>
            contrato.name.toUpperCase().contains(newQuery.toUpperCase()))
            .toList();
        PestanaContratante newContratante = new PestanaContratante.newPestana(
            pestanaContrato.nombre, pestanaContrato.index, items.length);
        newContratante.contratos = items;
        this.contratantes.add(newContratante);
      }
    }

    if (widget.anuncios != null) {
      this.anuncios = new List<PestanaAnuncios>();
      for (PestanaAnuncios pestanaAnuncio in widget.anuncios) {
        List<Anuncio> items = pestanaAnuncio.anuncios.where((contrato) => contrato.name.toUpperCase().contains(newQuery.toUpperCase())).toList();
        PestanaAnuncios newAnuncio = new PestanaAnuncios.newPestana(pestanaAnuncio.nombre, pestanaAnuncio.index, pestanaAnuncio.cantidad);
        newAnuncio.anuncios = items;
        this.anuncios.add(newAnuncio);
      }
    }

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
          },
        )
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
    List<Tab> tabs = new List<Tab>();
    List<Widget> contentTabs = new List<Widget>();

    if (this.contratantes != null && this.contratantes.length > 0) {
      for (PestanaContratante pestanaContratante in this.contratantes) {
        tabs.add(Tab(icon: Icon(FontAwesomeIcons.fileContract), text: pestanaContratante.nombre));
        contentTabs.add(ListView.builder(
            itemCount: pestanaContratante.contratos.length,
            itemBuilder: (context, index) {
              return ContratoItem(contrato: pestanaContratante.contratos[index]);
            }
        ));
      }
    } else if (this.anuncios != null && this.anuncios.length > 0) {
      for (PestanaAnuncios pestanaAnuncios in this.anuncios) {
        tabs.add(Tab(icon: Icon(FontAwesomeIcons.newspaper), text: pestanaAnuncios.nombre));
        contentTabs.add(ListView.builder(
            itemCount: pestanaAnuncios.anuncios.length,
            itemBuilder: (context, index) {
              return AnuncioItem(anuncio: pestanaAnuncios.anuncios[index]);
            }
        ));
      }
    }

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          leading: _isSearching ? new BackButton( color: Colors.white,) : null,
          title: _isSearching ? _buildSearchField() : _buildTitle(context),
          actions: _buildActions(),
          backgroundColor: Colors.blueAccent,
          bottom: TabBar(
            tabs: tabs,
            isScrollable: true,
          ),
        ),
        body: TabBarView(
            children: contentTabs
        ),
        drawer: DrawerApp(),
      ),
    );
  }
}

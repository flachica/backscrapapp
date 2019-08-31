import 'package:backscrapapp/src/ui/routes/initial_route.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:backscrapapp/src/tools/tools.dart';
import 'package:backscrapapp/src/ui/widgets/list_items/contrato_item.dart';
import 'package:backscrapapp/src/ui/widgets/list_items/anuncio_item.dart';
import 'package:backscrapapp/src/models/alldata_model.dart';
import 'package:backscrapapp/src/models/pestanacontratante_model.dart';
import 'package:backscrapapp/src/models/pestanaanuncio_model.dart';
import 'package:backscrapapp/src/models/contrato_model.dart';
import 'package:backscrapapp/src/models/anuncio_model.dart';
import 'package:backscrapapp/src/ui/widgets/drawer_list.dart';
import 'package:backscrapapp/src/resources/env.dart';

class ContentRoute extends StatefulWidget {
  static const routeName = '/content';

  String show;
  AllDataModel data;
  Env env;

  ContentRoute(BuildContext context, Env env) {
    RouteArguments arguments = ModalRoute.of(context).settings.arguments;
    if (arguments.data != null) data = arguments.data;
    this.show = arguments.show;
    if (this.show == null) this.show = CONTRATANTE_SHOW;
    this.env = env;
  }

  @override
  ContentRouteState createState() => new ContentRouteState();
}

class ContentRouteState extends State<ContentRoute> {
  bool _isSearching = false;
  Tools tools = new Tools();
  
  TextEditingController _searchQuery;
  List<PestanaContratante> pestanaContratantes;
  List<PestanaAnuncios> pestanaAnuncios;

  ContentRouteState();

  onMessage(message) async {
    widget.env.router.gotoRoute(context, InitialRoute.routeName, null);
  }

  onResume(message) async {
    widget.env.router.gotoRoute(context, InitialRoute.routeName, null);
  }

  @override
  void initState() {
    _searchQuery = new TextEditingController();
    if (widget.data != null) {
      if (widget.show == null || widget.show == CONTRATANTE_SHOW) {
        this.pestanaContratantes = widget.data.pestanaContratante;
      } else if (widget.show == ANUNCIOS_SHOW) {
        this.pestanaAnuncios = widget.data.pestanaAnuncios;
      }
    }
    widget.env.onMessage = this.onMessage;
    widget.env.onResume = this.onResume;
    super.initState();

    if (widget.env.pendingReadpush != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await this.onResume(widget.env.pendingReadpush);
      });
    }
    String routeName = ContentRoute.routeName;
    widget.env.repository.sendAnalyticsEvent('route.$routeName', widget.env.deviceInfo);
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
    if (widget.show == CONTRATANTE_SHOW && widget.data.pestanaContratante != null) {
      this.pestanaContratantes = new List<PestanaContratante>();
      for (PestanaContratante pestanaContrato in widget.data.pestanaContratante) {
        List<Contrato> items = pestanaContrato.contratos.where((contrato) =>
            contrato.name.toUpperCase().contains(newQuery.toUpperCase()))
            .toList();
        PestanaContratante newContratante = new PestanaContratante.newPestana(
            pestanaContrato.nombre, pestanaContrato.index, items.length);
        newContratante.contratos = items;
        this.pestanaContratantes.add(newContratante);
      }
    }

    if (widget.show == ANUNCIOS_SHOW && widget.data.pestanaAnuncios != null) {
      this.pestanaAnuncios = new List<PestanaAnuncios>();
      for (PestanaAnuncios pestanaAnuncio in widget.data.pestanaAnuncios) {
        List<Anuncio> items = pestanaAnuncio.anuncios.where((anuncio) => anuncio.name.toUpperCase().contains(newQuery.toUpperCase())).toList();
        PestanaAnuncios newAnuncio = new PestanaAnuncios.newPestana(pestanaAnuncio.nombre, pestanaAnuncio.index, pestanaAnuncio.cantidad);
        newAnuncio.anuncios = items;
        this.pestanaAnuncios.add(newAnuncio);
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
    String title = 'La Rinconada';
    return new InkWell(
      child: new Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: horizontalTitleAlignment,
          children: <Widget>[
            new Text(title,
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

    if (this.pestanaContratantes != null && this.pestanaContratantes.length > 0) {
      for (PestanaContratante pestanaContratante in this.pestanaContratantes) {
        var subicon = tools.iconContratoByIndex(pestanaContratante.index);
        Widget icon = subicon;
        if (pestanaContratante.nuevos > 0)
          icon = Badge(
            badgeColor: Colors.red,
            shape: BadgeShape.square,
            borderRadius: 20,
            elevation: 1,
            badgeContent: Text(pestanaContratante.nuevos.toString(), style: TextStyle(color: Colors.white),),
            child: subicon,
          );

        tabs.add(
            Tab(icon: icon,
                text: pestanaContratante.nombre)
        );
        contentTabs.add(ListView.builder(
            itemCount: pestanaContratante.contratos.length,
            itemBuilder: (context, index) {
              return ContratoItem(
                contrato: pestanaContratante.contratos[index],
                onExpansionChanged: (value) {
                  if (pestanaContratante.contratos[index].unreaded) {
                    widget.env.repository.deleteUnreadedContrato(pestanaContratante.contratos[index].id);
                    pestanaContratante.nuevos = pestanaContratante.nuevos - 1;
                    pestanaContratante.contratos[index].unreaded = false;
                    setState(() {});
                  }
                },
              );
            }
        ));
      }
    } else if (this.pestanaAnuncios != null && this.pestanaAnuncios.length > 0) {
      for (PestanaAnuncios pestanaAnuncios in this.pestanaAnuncios) {
        var subicon = tools.iconContratoByIndex(pestanaAnuncios.index);
        Widget icon = subicon;
        if (pestanaAnuncios.nuevos > 0)
          icon = Badge(
            badgeColor: Colors.red,
            shape: BadgeShape.square,
            borderRadius: 20,
            elevation: 1,
            badgeContent: Text(pestanaAnuncios.nuevos.toString(), style: TextStyle(color: Colors.white),),
            child: subicon,
          );
        tabs.add(Tab(icon: icon,
            text: pestanaAnuncios.nombre)
        );
        contentTabs.add(ListView.builder(
            itemCount: pestanaAnuncios.anuncios.length,
            itemBuilder: (context, index) {
              return AnuncioItem(
                  anuncio: pestanaAnuncios.anuncios[index],
                onExpansionChanged: (value) {
                  if (pestanaAnuncios.anuncios[index].unreaded) {
                    widget.env.repository.deleteUnreadedContrato(pestanaAnuncios.anuncios[index].id);
                    pestanaAnuncios.anuncios[index].unreaded = false;
                    pestanaAnuncios.nuevos = pestanaAnuncios.nuevos - 1;
                    setState(() {});
                  }
                }
              );
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
        drawer: DrawerApp(data: widget.data, env: widget.env,),
      ),
    );
  }
}

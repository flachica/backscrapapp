import 'package:backscrapapp/src/ui/routes/initial_route.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:backscrapapp/src/tools/tools.dart';
import 'package:backscrapapp/src/ui/widgets/list_items/publiccontract_item.dart';
import 'package:backscrapapp/src/ui/widgets/list_items/edict_item.dart';
import 'package:backscrapapp/src/models/alldata_model.dart';
import 'package:backscrapapp/src/models/tabpubliccontract_model.dart' show TabPublicContract;
import 'package:backscrapapp/src/models/tabedict_model.dart' show TabEdict;
import 'package:backscrapapp/src/models/publiccontract_model.dart';
import 'package:backscrapapp/src/models/edict_model.dart';
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
    if (this.show == null) this.show = PUBLICCONTRACTS_SHOW;
    this.env = env;
  }

  @override
  ContentRouteState createState() => new ContentRouteState();
}

class ContentRouteState extends State<ContentRoute> {
  bool _isSearching = false;
  Tools tools = new Tools();
  
  TextEditingController _searchQuery;
  List<TabPublicContract> tabPublicContracts;
  List<TabEdict> tabEdicts;

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
      if (widget.show == null || widget.show == PUBLICCONTRACTS_SHOW) {
        this.tabPublicContracts = widget.data.tabPublicContracts;
      } else if (widget.show == EDICTS_SHOW) {
        this.tabEdicts = widget.data.tabEdicts;
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
    if (widget.show == PUBLICCONTRACTS_SHOW && widget.data.tabPublicContracts != null) {
      this.tabPublicContracts = new List<TabPublicContract>();
      for (TabPublicContract typePublicContract in widget.data.tabPublicContracts) {
        List<PublicContract> items = typePublicContract.publicContracts.where((publicContract) =>
            publicContract.name.toUpperCase().contains(newQuery.toUpperCase()))
            .toList();
        TabPublicContract newTabPublicContract = new TabPublicContract.newtype(
            typePublicContract.name, typePublicContract.index, items.length);
        newTabPublicContract.publicContracts = items;
        this.tabPublicContracts.add(newTabPublicContract);
      }
    }

    if (widget.show == EDICTS_SHOW && widget.data.tabEdicts != null) {
      this.tabEdicts = new List<TabEdict>();
      for (TabEdict tabEdict in widget.data.tabEdicts) {
        List<Edict> items = tabEdict.edicts.where((edict) => edict.name.toUpperCase().contains(newQuery.toUpperCase())).toList();
        TabEdict newEdict = new TabEdict.newtype(tabEdict.name, tabEdict.index, tabEdict.count);
        newEdict.edicts = items;
        this.tabEdicts.add(newEdict);
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

    if (this.tabPublicContracts != null && this.tabPublicContracts.length > 0) {
      for (TabPublicContract tabPublicContract in this.tabPublicContracts) {
        var subicon = tools.iconPublicContractByIndex(tabPublicContract.index);
        Widget icon = subicon;
        if (tabPublicContract.fresh > 0)
          icon = Badge(
            badgeColor: Colors.red,
            shape: BadgeShape.square,
            borderRadius: 20,
            elevation: 1,
            badgeContent: Text(tabPublicContract.fresh.toString(), style: TextStyle(color: Colors.white),),
            child: subicon,
          );

        tabs.add(
            Tab(icon: icon,
                text: tabPublicContract.name)
        );
        contentTabs.add(ListView.builder(
            itemCount: tabPublicContract.publicContracts.length,
            itemBuilder: (context, index) {
              return PublicContractItem(
                publicContract: tabPublicContract.publicContracts[index],
                onExpansionChanged: (value) {
                  if (tabPublicContract.publicContracts[index].unreaded) {
                    widget.env.repository.deleteUnreadedPublicContract(tabPublicContract.publicContracts[index].id);
                    tabPublicContract.fresh = tabPublicContract.fresh - 1;
                    tabPublicContract.publicContracts[index].unreaded = false;
                    setState(() {});
                  }
                },
              );
            }
        ));
      }
    } else if (this.tabEdicts != null && this.tabEdicts.length > 0) {
      for (TabEdict tabEdict in this.tabEdicts) {
        var subicon = tools.iconPublicContractByIndex(tabEdict.index);
        Widget icon = subicon;
        if (tabEdict.fresh > 0)
          icon = Badge(
            badgeColor: Colors.red,
            shape: BadgeShape.square,
            borderRadius: 20,
            elevation: 1,
            badgeContent: Text(tabEdict.fresh.toString(), style: TextStyle(color: Colors.white),),
            child: subicon,
          );
        tabs.add(Tab(icon: icon,
            text: tabEdict.name)
        );
        contentTabs.add(ListView.builder(
            itemCount: tabEdict.edicts.length,
            itemBuilder: (context, index) {
              return EdictItem(
                  edict: tabEdict.edicts[index],
                onExpansionChanged: (value) {
                  if (tabEdict.edicts[index].unreaded) {
                    widget.env.repository.deleteUnreadedPublicContract(tabEdict.edicts[index].id);
                    tabEdict.edicts[index].unreaded = false;
                    tabEdict.fresh = tabEdict.fresh - 1;
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

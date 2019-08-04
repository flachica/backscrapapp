import 'package:flutter/material.dart';
import '../models/alldata_model.dart';
import '../blocs/data_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class AnuncioList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AnuncioListState();
  }
}

class AnuncioListState extends State<AnuncioList> {
  @override
  void initState() {
    super.initState();
    bloc.fetchPestanaAnuncios();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  StreamBuilder<AllDataModel> streamSliverAnuncio = StreamBuilder(
    stream: bloc.fetchAllData,
    builder: (context, AsyncSnapshot<AllDataModel> snapshot) {
      Widget resultWidget = SliverToBoxAdapter(child: new LinearProgressIndicator());

      if (snapshot.hasData) {
        resultWidget = SliverList(
            delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              String itemName = snapshot.data.pestanaAnuncios[index].anuncios[0].name;
              String fechaDesde = snapshot.data.pestanaAnuncios[index].anuncios[0].fecha_desde;
              String fechaHasta = snapshot.data.pestanaAnuncios[index].anuncios[0].fecha_hasta;
              String link = snapshot.data.pestanaAnuncios[index].anuncios[0].link;

              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                elevation: 2,
                margin: EdgeInsets.all(5.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExpansionTile(
                    backgroundColor: Colors.white,
                    title: new Text(itemName),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Text('Desde: ' + fechaDesde),
                            Spacer(),
                            Text('Hasta: ' + fechaHasta),
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Center(
                              child: new RaisedButton(
                                  color: Colors.blueAccent,
                                  textColor: Colors.white,
                                  child: new Text('Documento oficial'),
                                  onPressed: () => launch(link)
                              )
                          )
                      )
                    ],
                  ),
                ),
              );
            },
              childCount: snapshot.data.pestanaAnuncios.length
            ),
        );
      } else if (snapshot.hasError) {
        resultWidget = new SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(child: new Center(child: Text('Hubo un error que dice: ${snapshot.error}'),), height: 150.0),
            ],
          ),
        );

      }

      return CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            title: Text('Hola mundo'),
            backgroundColor: Colors.deepPurpleAccent,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset('img/larinconada.jpg', fit: BoxFit.cover),
            ),
            expandedHeight: 200,
          ),
          resultWidget
        ],
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: streamSliverAnuncio
    );
  }
}
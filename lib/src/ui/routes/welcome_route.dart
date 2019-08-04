import 'package:flutter/material.dart';
import 'package:backscrapapp/src/ui/skeletons/iconic_grid.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:backscrapapp/src/ui/skeletons/main_skeleton.dart';
import 'package:backscrapapp/src/blocs/data_bloc.dart';
import 'package:backscrapapp/src/models/alldata_model.dart';
import 'package:backscrapapp/src/ui/navigations/welcome_navigation.dart';
import 'package:backscrapapp/src/ui/widgets/labeled_image.dart';
import 'package:backscrapapp/src/ui/widgets/basic_card.dart';

class WelcomeRoute extends StatefulWidget {
  static const routeName = '/';

  @override
  State<StatefulWidget> createState() {
    return WelcomeState();
  }
}

class WelcomeState extends State<WelcomeRoute> {
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
        Size deviceSize = MediaQuery.of(context).size;

        Widget resultWidget = SizedBox.fromSize(
            size: Size.square(deviceSize.height / 3.1),
            child: Center(
              child: CircularProgressIndicator(),
            ));

        if (snapshot.hasData) {
          resultWidget = SizedBox.fromSize(
            size: Size.square(deviceSize.height / 3.1),
            child: Column(children: <Widget>[
              IconicGridTwo(
                firstIcon: FontAwesomeIcons.fileContract,
                firstLabel: "Contratos",
                firstOnPressed: () =>
                    WelcomeNavigation.firstOnPressed(context, snapshot.data),
                secondIcon: FontAwesomeIcons.newspaper,
                secondLabel: "Anuncios",
                secondOnPressed: () =>
                    WelcomeNavigation.secondOnPressed(context, snapshot.data),
              )
            ]),
          );
        }

        return ListView(
          children: <Widget>[
            LabeledImage(
              text: 'En La Rinconada',
              imageURL: 'img/city.png',
              deviceSize: deviceSize,
            ),
            LabeledImage(
              text: 'Hay información útil',
              imageURL: 'img/info.png',
              deviceSize: deviceSize,
            ),
            LabeledImage(
              text: 'Si eres empresa',
              imageURL: 'img/company.png',
              deviceSize: deviceSize,
            ),
            LabeledImage(
              text: 'Asociación',
              imageURL: 'img/ong.png',
              deviceSize: deviceSize,
            ),
            LabeledImage(
              text: 'O para uso personal',
              imageURL: 'img/personal.png',
              deviceSize: deviceSize,
            ),
            LabeledImage(
              text: 'Útil y en el momento',
              imageURL: 'img/justintime.png',
              deviceSize: deviceSize,
            ),
            BasicCard(
              content: Container(
                  padding: const EdgeInsets.all(32),
                  child: Text(
                    'Consulte toda la oferta pública del Ayuntamiento de La Rinconada ',
                    softWrap: true,
                    textAlign: TextAlign.justify,
                  )
              ),
            ),
            resultWidget
          ],
        );
      });

  Widget bodyData(context) => ListView(
        children: <Widget>[
          Image.asset('img/larinconada.jpg', height: 200, fit: BoxFit.cover),
          Container(
              padding: const EdgeInsets.all(32),
              child: Text(
                'Toda la información pública y de interés en tu mano.'
                '\n\n'
                'Conocerás toda la oferta pública del Ayuntamiento de La Rinconada '
                'como puedan ser licitaciones, concursos públicos, becas, subvenciones . . .'
                '\n\n'
                'Información útil y en el momento que te servirá tanto si eres empresa, ONG o persona física.',
                softWrap: true,
                textAlign: TextAlign.justify,
              )),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return MainSkeleton(
      body: streamSliverAnuncio,
    );
  }
}

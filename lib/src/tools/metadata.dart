import 'package:backscrapapp/src/models/pestanacontratante_model.dart';
import 'package:backscrapapp/src/models/pestanaanuncio_model.dart';

class RouteArguments {
  final String fromName;
  final List<PestanaContratante> contratantes;
  final List<PestanaAnuncios> anuncios;

  RouteArguments({this.fromName, this.contratantes, this.anuncios});
}
import 'package:backscrapapp/src/models/pestanaanuncio_model.dart';
import 'package:backscrapapp/src/models/pestanacontratante_model.dart';


class AllDataModel {
  List<PestanaAnuncios> _pestanaAnuncios = [];
  List<PestanaContratante> _pestanaContratante = [];

  AllDataModel.fromJSON(Map<String, dynamic> parsedJSON) {
    for (Map<String, dynamic> item in parsedJSON['anuncios']) {
      _pestanaAnuncios.add(new PestanaAnuncios(item));
    }

    for (Map<String, dynamic> item in parsedJSON['contratantes']) {
      _pestanaContratante.add(new PestanaContratante(item));
    }
  }

  List<PestanaAnuncios> get pestanaAnuncios => _pestanaAnuncios;
  List<PestanaContratante> get pestanaContratante => _pestanaContratante;
}
import 'package:backscrapapp/src/models/pestanaanuncio_model.dart';
import 'package:backscrapapp/src/models/pestanacontratante_model.dart';
import 'package:backscrapapp/src/models/anuncio_model.dart';
import 'package:backscrapapp/src/models/contrato_model.dart';


class AllDataModel {
  List<PestanaAnuncios> _pestanaAnuncios = [];
  List<PestanaContratante> _pestanaContratante = [];
  List<Anuncio> _anuncios = [];
  List<Contrato> _contratos = [];

  AllDataModel(): super();

  AllDataModel.fromJSON(Map<String, dynamic> parsedJSON) {
    for (Map<String, dynamic> item in parsedJSON['anuncios']) {
      PestanaAnuncios _pestanaAnuncio = new PestanaAnuncios(item);
      _pestanaAnuncios.add(_pestanaAnuncio);
      for (Anuncio _anuncio in _pestanaAnuncio.anuncios) {
        _anuncios.add(_anuncio);
      }
    }

    for (Map<String, dynamic> item in parsedJSON['contratantes']) {
      PestanaContratante _pestanaContrato = new PestanaContratante(item);
      _pestanaContratante.add(_pestanaContrato);
      for (Contrato _contrato in _pestanaContrato.contratos) {
        _contratos.add(_contrato);
      }
    }
  }

  List<PestanaAnuncios> get pestanaAnuncios => _pestanaAnuncios;
  List<PestanaContratante> get pestanaContratante => _pestanaContratante;
  List<Anuncio> get anuncios => _anuncios;
  List<Contrato> get contratos => _contratos;
}
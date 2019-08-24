import 'package:backscrapapp/src/models/pestanaanuncio_model.dart';
import 'package:backscrapapp/src/models/pestanacontratante_model.dart';
import 'package:backscrapapp/src/models/anuncio_model.dart';
import 'package:backscrapapp/src/models/contrato_model.dart';


class AllDataModel {
  List<PestanaAnuncios> _pestanaAnuncios = [];
  List<PestanaContratante> _pestanaContratante = [];
  List<Anuncio> _anuncios = [];
  List<Contrato> _contratos = [];
  int _lastAnuncio;
  int _lastContrato;

  AllDataModel(): super();

  AllDataModel.fromJSON(Map<String, dynamic> parsedJSON, List<int> unreadedAnuncios, List<int> unreadedContratos) {
    for (Map<String, dynamic> item in parsedJSON['anuncios']) {
      PestanaAnuncios _pestanaAnuncio = new PestanaAnuncios(item, unreadedAnuncios);
      _pestanaAnuncios.add(_pestanaAnuncio);
      for (Anuncio _anuncio in _pestanaAnuncio.anuncios) {
        _anuncios.add(_anuncio);
      }
    }

    for (Map<String, dynamic> item in parsedJSON['contratantes']) {
      PestanaContratante _pestanaContrato = new PestanaContratante(item, unreadedContratos);
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
  int get lastAnuncio => _lastAnuncio;
  int get lastContrato => _lastContrato;
}
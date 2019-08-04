import 'package:backscrapapp/src/models/anuncio_model.dart';

class PestanaAnuncios {
  String _nombre;
  List<Anuncio> _anuncios = [];
  int _index;
  int _cantidad;

  PestanaAnuncios(pestana) {
    _nombre = pestana['nombre'];
    _index = pestana['index'];
    _cantidad = pestana['cantidad'];

    for (Map<String, dynamic>  anuncio in pestana['items']) {
      _anuncios.add(new Anuncio(anuncio));
    }
  }

  String get nombre => _nombre;
  List<Anuncio> get anuncios => _anuncios;
  int get index => _index;
  int get cantidad => _cantidad;
}
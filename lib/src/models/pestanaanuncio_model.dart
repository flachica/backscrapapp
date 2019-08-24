import 'package:backscrapapp/src/models/anuncio_model.dart';

class PestanaAnuncios {
  String _nombre;
  List<Anuncio> _anuncios = [];
  int _index;
  int _cantidad;
  int _nuevos =  0;

  PestanaAnuncios(Map<String, dynamic> pestana, List<int> unreaded) {
    _nombre = pestana['nombre'];
    _index = pestana['index'];
    _cantidad = pestana['cantidad'];

    for (Map<String, dynamic>  anuncio in pestana['items']) {
      if (unreaded.contains(anuncio['id'])) {
        anuncio['unreaded'] = true;
        _nuevos += 1;
      } else {
        anuncio['unreaded'] = false;
      }
      _anuncios.add(new Anuncio(anuncio));
    }
  }

  PestanaAnuncios.newPestana(String nombre, int index, int cantidad) {
    this._nombre = nombre;
    this._index = index;
    this._cantidad = cantidad;
  }

  String get nombre => _nombre;
  List<Anuncio> get anuncios => _anuncios;
  int get index => _index;
  int get cantidad => _cantidad;
  int get nuevos => _nuevos;

  set anuncios (anuncios) => this._anuncios = anuncios;
  set nuevos (nuevos) {
    this._nuevos = nuevos;
  }
}
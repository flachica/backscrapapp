import 'package:backscrapapp/src/models/contrato_model.dart';

class PestanaContratante {
  String _nombre;
  List<Contrato> _contratos = [];
  int _index;
  int _cantidad;

  PestanaContratante(pestana) {
    _nombre = pestana['nombre'];
    _index = pestana['index'];
    _cantidad = pestana['cantidad'];

    for (Map<String, dynamic>  contrato in pestana['items']) {
      _contratos.add(new Contrato(contrato));
    }
  }

  PestanaContratante.newPestana(String nombre, int index, int cantidad) {
    this._nombre = nombre;
    this._index = index;
    this._cantidad = cantidad;
  }

  String get nombre => _nombre;
  List<Contrato> get contratos => _contratos;
  int get index => _index;
  int get cantidad => _cantidad;

  set contratos (contratos) => this._contratos = contratos;
}
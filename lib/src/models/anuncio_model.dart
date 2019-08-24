class Anuncio {
  int _id;
  String _pestana;
  String _name;
  String _fecha_desde;
  String _fecha_hasta;
  String _link;
  String _identificador;
  String _contenido;
  List<String> _tags;
  bool _unreaded;

  Anuncio(anuncio) {
    _id = anuncio['id'];
    _pestana = anuncio['pestana'];
    _name = anuncio['name'];
    _fecha_desde = anuncio['fecha_desde'];
    _fecha_hasta = anuncio['fecha_hasta'];
    _link = anuncio['link'];
    _identificador = anuncio['identificador'];
    _contenido = anuncio['contenido'];
    _tags = [anuncio['pestana']];
    _unreaded = anuncio['unreaded'];
  }

  int get id => _id;
  String get pestana => _pestana;
  String get name => _name;
  String get fecha_desde => _fecha_desde;
  String get fecha_hasta => _fecha_hasta;
  String get link => _link;
  String get identificador => _identificador;
  String get contenido => _contenido;
  List<String> get tags => _tags;
  bool get unreaded => _unreaded;
  set unreaded(bool unredad) {
    this._unreaded = false;
  }
}
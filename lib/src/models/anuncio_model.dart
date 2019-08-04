class Anuncio {
  int _id;
  String _pestana;
  String _name;
  String _fecha_desde;
  String _fecha_hasta;
  String _link;

  Anuncio(anuncio) {
    _id = anuncio['id'];
    _pestana = anuncio['pestana'];
    _name = anuncio['name'];
    _fecha_desde = anuncio['fecha_desde'];
    _fecha_hasta = anuncio['fecha_hasta'];
    _link = anuncio['link'];
  }

  int get id => _id;
  String get pestana => _pestana;
  String get name => _name;
  String get fecha_desde => _fecha_desde;
  String get fecha_hasta => _fecha_hasta;
  String get link => _link;
}
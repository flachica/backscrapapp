class Contrato {
  int _id;
  String _type;
  String _name;
  String _status;
  String _expediente;
  String _estadoexpediente;
  String _procedimiento;
  String _descripcion;
  String _tipo;
  String _precio;
  String _fecha_hasta;
  String _link;
  String _identificador;
  List<String> _tags;
  bool _unreaded;

  Contrato(contrato) {
    _id = contrato['id'];
    _type = contrato['type'];
    _name = contrato['name'];
    _status = contrato['status'];
    _expediente = contrato['expediente'];
    _estadoexpediente = contrato['estadoexpediente'];
    _procedimiento = contrato['procedimiento'];
    _descripcion = contrato['descripcion'];
    _tipo = contrato['tipo'];
    _precio = contrato['precio'];
    _fecha_hasta = contrato['fecha_hasta'];
    _link = contrato['link'];
    _identificador = contrato['identificador'];
    _tags = [contrato['type']];
    _unreaded = contrato['unreaded'];
  }

  int get id => _id;
  String get type => _type;
  String get name => _name;
  String get status => _status;
  String get expediente => _expediente;
  String get estadoexpediente => _estadoexpediente;
  String get procedimiento => _procedimiento;
  String get descripcion => _descripcion;
  String get tipo => _tipo;
  String get precio => _precio;
  String get fecha_hasta => _fecha_hasta;
  String get link => _link;
  String get identificador => _identificador;
  List<String> get tags => _tags;
  bool get unreaded => _unreaded;
  set unreaded(bool unredad) {
    this._unreaded = false;
  }
}
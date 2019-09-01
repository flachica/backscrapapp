class Edict {
  int _id;
  String _type;
  String _name;
  String _date_from;
  String _date_to;
  String _link;
  String _hash;
  String _content;
  bool _unreaded;

  Edict(edict) {
    _id = edict['id'];
    _type = edict['type'];
    _name = edict['name'];
    _date_from = edict['date_from'];
    _date_to = edict['date_to'];
    _link = edict['link'];
    _hash = edict['hash'];
    _content = edict['content'];
    _unreaded = edict['unreaded'];
  }

  int get id => _id;
  String get type => _type;
  String get name => _name;
  String get date_from => _date_from;
  String get date_to => _date_to;
  String get link => _link;
  String get hash => _hash;
  String get content => _content;
  bool get unreaded => _unreaded;
  set unreaded(bool unredad) {
    this._unreaded = false;
  }
}
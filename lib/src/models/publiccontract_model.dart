class PublicContract {
  int _id;
  String _type;
  String _name;
  String _status;
  String _contract_record;
  String _status_record;
  String _procedure;
  String _description;
  String _subtype;
  String _price;
  String _date_to;
  String _link;
  String _hash;
  bool _unreaded;

  PublicContract(publicContract) {
    _id = publicContract['id'];
    _type = publicContract['type'];
    _name = publicContract['name'];
    _status = publicContract['status'];
    _contract_record = publicContract['contract_record'];
    _status_record = publicContract['status_record'];
    _procedure = publicContract['procedure'];
    _description = publicContract['description'];
    _subtype = publicContract['subtype'];
    _price = publicContract['price'];
    _date_to = publicContract['date_to'];
    _link = publicContract['link'];
    _hash = publicContract['hash'];
    _unreaded = publicContract['unreaded'];
  }

  int get id => _id;
  String get type => _type;
  String get name => _name;
  String get status => _status;
  String get contract_record => _contract_record;
  String get status_record => _status_record;
  String get procedure => _procedure;
  String get description => _description;
  String get subtype => _subtype;
  String get price => _price;
  String get date_to => _date_to;
  String get link => _link;
  String get hash => _hash;
  bool get unreaded => _unreaded;
  set unreaded(bool unredad) {
    this._unreaded = false;
  }
}
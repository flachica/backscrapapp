import 'package:backscrapapp/src/models/edict_model.dart';

class TabEdict {
  String _name;
  List<Edict> _edicts = [];
  int _index;
  int _count;
  int _fresh =  0;

  TabEdict(Map<String, dynamic> type, List<int> unreaded) {
    _name = type['name'];
    _index = type['index'];
    _count = type['count'];

    for (Map<String, dynamic>  edict in type['items']) {
      if (unreaded.contains(edict['id'])) {
        edict['unreaded'] = true;
        _fresh += 1;
      } else {
        edict['unreaded'] = false;
      }
      _edicts.add(new Edict(edict));
    }
  }

  TabEdict.newtype(String name, int index, int count) {
    this._name = name;
    this._index = index;
    this._count = count;
  }

  String get name => _name;
  List<Edict> get edicts => _edicts;
  int get index => _index;
  int get count => _count;
  int get fresh => _fresh;

  set edicts (edicts) => this._edicts = edicts;
  set fresh (fresh) {
    this._fresh = fresh;
  }
}
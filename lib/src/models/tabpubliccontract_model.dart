import 'package:backscrapapp/src/models/publiccontract_model.dart';

class TabPublicContract {
  String _name;
  List<PublicContract> _publicContracts = [];
  int _index;
  int _count;
  int _fresh = 0;

  TabPublicContract(Map<String, dynamic> type, List<int> unreaded) {
    _name = type['name'];
    _index = type['index'];
    _count = type['count'];

    for (Map<String, dynamic>  publicContract in type['items']) {
      if (unreaded.contains(publicContract['id'])) {
        publicContract['unreaded'] = true;
        _fresh += 1;
      } else {
        publicContract['unreaded'] = false;
      }
      _publicContracts.add(new PublicContract(publicContract));
    }
  }

  TabPublicContract.newtype(String name, int index, int count) {
    this._name = name;
    this._index = index;
    this._count = count;
  }

  String get name => _name;
  List<PublicContract> get publicContracts => _publicContracts;
  int get index => _index;
  int get count => _count;
  int get fresh => _fresh;

  set publicContracts (publicContracts) => this._publicContracts = publicContracts;
  set fresh (fresh) {
    this._fresh = fresh;
  }
}
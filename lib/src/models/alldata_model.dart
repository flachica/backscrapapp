import 'package:backscrapapp/src/models/tabedict_model.dart' show TabEdict;
import 'package:backscrapapp/src/models/tabpubliccontract_model.dart'
    show TabPublicContract;
import 'package:backscrapapp/src/models/edict_model.dart';
import 'package:backscrapapp/src/models/publiccontract_model.dart';

class AllDataModel {
  List<TabEdict> _tabEdicts = [];
  List<TabPublicContract> _tabPublicContracts = [];
  List<Edict> _edicts = [];
  List<PublicContract> _publicContracts = [];
  int _lastEdict;
  int _lastPublicContract;

  AllDataModel() : super();

  AllDataModel.fromJSON(Map<String, dynamic> parsedJSON,
      List<int> unreadedEdicts, List<int> unreadedPublicContracts) {
    for (Map<String, dynamic> item in parsedJSON['edicts']) {
      TabEdict _tabEdict = new TabEdict(item, unreadedEdicts);
      _tabEdicts.add(_tabEdict);
      for (Edict _edict in _tabEdict.edicts) {
        _edicts.add(_edict);
      }
    }

    for (Map<String, dynamic> item in parsedJSON['publiccontracts']) {
      TabPublicContract _typePublicContract =
          new TabPublicContract(item, unreadedPublicContracts);
      _tabPublicContracts.add(_typePublicContract);
      for (PublicContract _publicContract
          in _typePublicContract.publicContracts) {
        _publicContracts.add(_publicContract);
      }
    }
  }

  List<TabEdict> get tabEdicts => _tabEdicts;

  List<TabPublicContract> get tabPublicContracts => _tabPublicContracts;

  List<Edict> get edicts => _edicts;

  List<PublicContract> get publicContracts => _publicContracts;

  int get lastEdict => _lastEdict;

  int get lastPublicContract => _lastPublicContract;
}

import 'package:backscrapapp/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:backscrapapp/src/models/alldata_model.dart';

class DataBloc {
  final _repository = Repository();
  final _dataFetcher = PublishSubject<AllDataModel>();

  Observable<AllDataModel> get fetchAllData => _dataFetcher.stream;

  fetchPestanaAnuncios() async {
    _dataFetcher.sink.add(await _repository.getAllData());
  }

  dispose() {
    _dataFetcher.close();
  }
}

final bloc = DataBloc();
import 'package:rxdart/rxdart.dart';
import 'package:backscrapapp/src/models/alldata_model.dart';
import 'package:backscrapapp/src/resources/env.dart';

class DataBloc {
  Env env;
  final _dataFetcher = PublishSubject<AllDataModel>();

  DataBloc(Env env) {
    this.env = env;
  }

  Observable<AllDataModel> get fetchAllData => _dataFetcher.stream;

  fetchPestanaAnuncios() async {
    _dataFetcher.sink.add(await this.env.repository.getAllData());
  }

  dispose() {
    _dataFetcher.close();
  }
}
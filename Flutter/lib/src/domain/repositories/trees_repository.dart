import 'package:green_it/src/data/remote/rest_client.dart';
import 'package:green_it/src/domain/models/trees_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class TreesRepository {
  final RestClient _restClient;
  TreesRepository(this._restClient);

  Future<DataSet> getTreesInParis() {
    return _restClient.getDataSets();
  }
}

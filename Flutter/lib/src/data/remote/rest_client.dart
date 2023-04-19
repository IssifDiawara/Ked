import 'package:dio/dio.dart';
import 'package:green_it/src/data/remote/dio_client.dart';
import 'package:green_it/src/di/global_dependencies.dart';
import 'package:green_it/src/domain/models/trees_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: 'https://documentation-resources.opendatasoft.com/api/records/1.0')
@injectable
abstract class RestClient {
  @factoryMethod
  factory RestClient(Dio dio) = _RestClient;

  @GET('/search')
  Future<DataSet> getDataSets(
      {@Query('dataset') String? dataSet = 'les-arbres-remarquables-de-paris',
      @Query('format') String? format = 'json'});
}

@module
abstract class ServiceModule {
  @lazySingleton
  Dio get dio => getIt<DioClient>().getApiDio();
}

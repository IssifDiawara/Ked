import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DioClient {
  Dio getApiDio() => Dio()
    ..options.contentType = Headers.formUrlEncodedContentType
    ..interceptors.add(
      LogInterceptor(
        responseBody: true,
        requestBody: true,
      ),
    );
}

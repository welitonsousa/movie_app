import 'package:dio/dio.dart';
import 'package:movie_app/core/rest_client/rest_client.dart';
import 'package:movie_app/env.dart';

class DioClient extends RestClient {
  final _dio = Dio(BaseOptions(
    baseUrl: Env.BASE_URL,
    receiveTimeout: Env.TIME_OUT_MILLISECONDS,
    queryParameters: {'api_key': Env.API_KEY, 'language': 'pt-BR'},
  ));

  @override
  Future<Map<String, dynamic>> get(String path,
      {Map<String, dynamic>? params}) async {
    final response = await _dio.get(path, queryParameters: params);
    return response.data;
  }
}

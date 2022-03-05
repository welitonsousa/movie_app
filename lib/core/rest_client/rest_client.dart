import 'package:get/get_connect.dart';

class RestClient extends GetConnect {
  String url = 'https://api.themoviedb.org/3';
  RestClient() {
    httpClient.baseUrl = url;
    httpClient.errorSafety = false;
    httpClient.timeout = const Duration(seconds: 30);
  }
}

abstract class RestClient {
  Future<Map<String, dynamic>> get(String path, {Map<String, dynamic>? params});
}

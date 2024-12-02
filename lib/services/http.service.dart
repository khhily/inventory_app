class HttpService {
  HttpService._();

  static final HttpService _instance = HttpService._();

  factory HttpService() => _instance;

  Future post({
    required String url,
    required dynamic data,
  }) async {}
}

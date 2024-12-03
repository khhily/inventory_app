import 'package:dio/dio.dart';

class HttpService {
  HttpService._();

  static final HttpService _instance = HttpService._();

  factory HttpService() => _instance;

  late final Dio _dio;

  init() {
    _dio = Dio();
  }

  Future<T?> post<T>({
    required String url,
    dynamic data,
    Map<String, dynamic>? query,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    final response = await _dio.post<T>(
      url,
      data: data,
      queryParameters: query,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    return response.data;
  }
}

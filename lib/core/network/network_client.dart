//Singleton of network client using dio

import 'package:dio/dio.dart';

class NetworkClient {
  static final NetworkClient _instance = NetworkClient._internal();
  final Dio _dio = Dio();

  factory NetworkClient() {
    return _instance;
  }

  NetworkClient._internal() {
    _dio.options.baseUrl = 'https://dummyjson.com/';
    _dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  Future<Response> get<T>(String path,
      {Map<String, Object?>? queryParameters}) {
    return _dio.get<T>(path, queryParameters: queryParameters);
  }

  Future<Response> post<T>(String path, {Map<String, Object?>? data}) {
    return _dio.post<T>(path, data: data);
  }
}

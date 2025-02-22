import 'package:dio/dio.dart';

class ServerException implements Exception {
  final String detail;
  final DioException? error;

  ServerException({required this.detail, this.error});
}

class CacheException implements Exception {
  final String detail;
  final Exception? error;

  CacheException({required this.detail, this.error});
}

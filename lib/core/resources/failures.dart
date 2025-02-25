import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_mite/core/resources/exceptions.dart';

abstract class Failure extends Equatable {
  final String detail;

  Failure({required this.detail});

  @override
  List<Object> get props => [detail];
}

// General failures
class ServerFailure extends Failure {
  ServerFailure({required String detail}) : super(detail: detail);

  // Use DioException if available
  factory ServerFailure.fromServerException(ServerException exception) {
    final error = exception.error;
    if (error != null) {
      return ServerFailure.fromDioException(error);
    } else {
      return ServerFailure(detail: exception.detail);
    }
  }

  factory ServerFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ServerFailure(
          detail: "Server took too long to respond. Please try again later.",
        );
      case DioExceptionType.badCertificate:
        return ServerFailure(detail: "Bad certificate.");
      case DioExceptionType.badResponse:
        return ServerFailure(
          detail: "Something went wrong. Please try again later.",
        );
      case DioExceptionType.cancel:
        return ServerFailure(detail: "Request to server was cancelled.");
      case DioExceptionType.connectionError:
        return ServerFailure(
          detail:
              "Could not connect to the server. Please check your internet connection and try again later.",
        );
      case DioExceptionType.unknown:
        return ServerFailure(detail: "Unknown error.");
    }
  }
}

class CacheFailure extends Failure {
  CacheFailure({required String detail}) : super(detail: detail);
}

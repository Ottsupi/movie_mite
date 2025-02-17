import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String detail;

  Failure({required this.detail});

  @override
  List<Object> get props => [detail];
}

// General failures
class ServerFailure extends Failure {
  ServerFailure({required String detail}) : super(detail: detail);
}

class CacheFailure extends Failure {
  CacheFailure({required String detail}) : super(detail: detail);
}

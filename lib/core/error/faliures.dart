import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class NetworkFailure implements Failure {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;
}

class ServerFailure implements Failure {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;
}

class EmptyResultFailure implements Failure {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;
}

class EmptyCacheFailure implements Failure {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;
}

class CacheFailure implements Failure {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;
}

class InvalidCredentialsFailure implements Failure {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;
}

class UnAuthorizedFailure implements Failure {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;
}

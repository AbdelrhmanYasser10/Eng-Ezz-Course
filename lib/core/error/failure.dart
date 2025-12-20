abstract class Failure {
  final String message;
  const Failure({required this.message});
}

class ServerFailure extends Failure{
  ServerFailure({required super.message});
}

class NetworkFailure extends Failure{
  NetworkFailure({required super.message});
}
class CacheSavingError extends Failure{
  CacheSavingError({required super.message});
}

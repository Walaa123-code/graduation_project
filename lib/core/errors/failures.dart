abstract class Failures {
  dynamic errors;

  Failures({required this.errors});
}

class ServerError extends Failures {
  ServerError({required super.errors});
}

class NetworkError extends Failures {
  NetworkError({required super.errors});
}

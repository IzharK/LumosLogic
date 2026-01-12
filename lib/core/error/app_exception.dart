class AppException implements Exception {
  final String message;
  final String prefix;

  AppException([this.message = 'Something went wrong', this.prefix = 'Error']);

  @override
  String toString() {
    return '$prefix: $message';
  }
}

class FetchDataException extends AppException {
  FetchDataException([String message = 'Error During Communication'])
    : super(message, 'Error During Communication');
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, 'Invalid Request');
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, 'Unauthorised');
}

class InvalidInputException extends AppException {
  InvalidInputException([String message = 'Invalid Input'])
    : super(message, 'Invalid Input');
}

class NoBookingBookingException extends AppException {
  NoBookingBookingException([String message = 'Invalid Input'])
    : super(message, 'Invalid Input');
}

class CacheException extends AppException {
  CacheException([String message = 'Cache Error'])
    : super(message, 'Cache Error');
}

class NoInternetException extends AppException {
  NoInternetException([String message = 'No Internet Connection'])
    : super(message, 'No Internet');
}

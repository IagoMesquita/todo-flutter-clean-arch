class FirestoreException implements Exception {
  final String message;
  final String? code;
  final StackTrace? stackTrace;

  const FirestoreException(
      {required this.message,  this.code, this.stackTrace});

  @override
  String toString() => 'FirestoreException($code): $message\n$stackTrace';
}

class GetToDosException extends FirestoreException {
  const GetToDosException(String message, String? code, StackTrace? stackTrace)
      : super(
          message: message,
          code: code,
          stackTrace: stackTrace,
        );
}

class AddToDoException extends FirestoreException {
  AddToDoException(
    String message,
    String? code,
    StackTrace? stackTrace,
  ) : super(
          message: message,
          code: code,
          stackTrace: stackTrace,
        );
}

class ToggleToDoException extends FirestoreException {
  ToggleToDoException(
    String message,
    String? code,
    StackTrace? stackTrace,
  ) : super(
          message: message,
          code: code,
          stackTrace: stackTrace,
        );
}

class DeleteToDoException extends FirestoreException {
  DeleteToDoException(
    String message,
    String? code,
    StackTrace? stackTrace,
  ) : super(
          message: message,
          code: code,
          stackTrace: stackTrace,
        );
}
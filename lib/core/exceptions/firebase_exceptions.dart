class FirestoreException implements Exception {
  final String message;
  final String? code;
  final StackTrace? stackTrace;
  final String operation;

  const FirestoreException({
    required this.message,
    required this.operation,
    this.code,
    this.stackTrace,

  });

  @override
  String toString() => 'FirestoreException($operation, $code): $message\n$stackTrace';
}

// Nao sao utei nesse momento.
// class GetToDosException extends FirestoreException {
//   const GetToDosException(String message, String? code, StackTrace? stackTrace)
//       : super(
//           message: message,
//           code: code,
//           stackTrace: stackTrace,
//         );
// }

// class AddToDoException extends FirestoreException {
//   AddToDoException(
//     String message,
//     String? code,
//     StackTrace? stackTrace,
//   ) : super(
//           message: message,
//           code: code,
//           stackTrace: stackTrace,
//         );
// }

// class ToggleToDoException extends FirestoreException {
//   ToggleToDoException(
//     String message,
//     String? code,
//     StackTrace? stackTrace,
//   ) : super(
//           message: message,
//           code: code,
//           stackTrace: stackTrace,
//         );
// }

// class DeleteToDoException extends FirestoreException {
//   DeleteToDoException(
//     String message,
//     String? code,
//     StackTrace? stackTrace,
//   ) : super(
//           message: message,
//           code: code,
//           stackTrace: stackTrace,
//         );
// }
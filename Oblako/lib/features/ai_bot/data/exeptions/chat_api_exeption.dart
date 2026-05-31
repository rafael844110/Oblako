class ChatApiException implements Exception {
  final String message;
  final int? statusCode;

  ChatApiException(this.message, {this.statusCode});

  @override
  String toString() => 'ChatApiException: $message (Status: $statusCode)';
}

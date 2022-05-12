class ErrorResponse {
  DateTime timestamp;
  int status;
  String error;
  String errorCode;
  String message;

  ErrorResponse({
    required this.timestamp,
    required this.status,
    required this.error,
    required this.errorCode,
    required this.message,
  });

  ErrorResponse.fromJson(Map json)
      : timestamp = DateTime.parse(json['timestamp']),
        status = json['status'],
        error = json['error'],
        errorCode = json['errorCode'],
        message = json['message'];
}

class AuthResponse {
  final String message;
  final bool success;
  final dynamic data;

  AuthResponse(
      {required this.message, required this.success, required this.data});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
        message: json['message'] ?? '',
        success: json['success'],
        data: json['data']);
  }

  @override
  String toString() {
    return 'AuthResponse{message: $message, success:$success data: $data}';
  }
}

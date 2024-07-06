class GeneralResponse {
  final String message;
  final bool success;
  final dynamic data;

  GeneralResponse(
      {required this.message, required this.success, required this.data});

  factory GeneralResponse.fromJson(Map<String, dynamic> json) {
    return GeneralResponse(
        message: json['message'] ?? '',
        success: json['success'],
        data: json['data']);
  }

  @override
  String toString() {
    return 'AuthResponse{message: $message, success:$success data: $data}';
  }
}

/// Generic typed wrapper for all API responses.
class ApiResponse<T> {
  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic)? fromJsonT,
  ) {
    return ApiResponse<T>(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      data: fromJsonT != null && json['data'] != null
          ? fromJsonT(json['data'])
          : null,
      statusCode: json['statusCode'] as int?,
    );
  }
  const ApiResponse({
    required this.success,
    required this.message,
    this.data,
    this.statusCode,
  });

  final bool success;
  final String message;
  final T? data;
  final int? statusCode;
}

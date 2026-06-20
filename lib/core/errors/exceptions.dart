import 'package:flutter/foundation.dart'; // مهمة جداً عشان kDebugMode
import 'package:flutter/material.dart';

// ── Custom App Exceptions ──────────────────────────────────────────

/// Thrown when a network request times out
class TimeoutException implements Exception {
  final String message;
  const TimeoutException([this.message = 'Request timed out']);
  @override
  String toString() => 'TimeoutException: $message';
}

/// Thrown when there is no internet connection
class NoInternetException implements Exception {
  final String message;
  const NoInternetException([this.message = 'No internet connection']);
  @override
  String toString() => 'NoInternetException: $message';
}

/// Thrown when the server returns an unexpected error (5xx)
class ServerException implements Exception {
  final String message;
  final int? statusCode;
  const ServerException({this.message = 'Server error', this.statusCode});
  @override
  String toString() => 'ServerException[$statusCode]: $message';
}

/// Thrown when authentication fails (401/403)
class UnauthorizedException implements Exception {
  final String message;
  const UnauthorizedException([this.message = 'Unauthorized']);
  @override
  String toString() => 'UnauthorizedException: $message';
}

/// Thrown when a resource is not found (404)
class NotFoundException implements Exception {
  final String message;
  const NotFoundException([this.message = 'Resource not found']);
  @override
  String toString() => 'NotFoundException: $message';
}

/// Thrown when data parsing/serialization fails
class ParseException implements Exception {
  final String message;
  const ParseException([this.message = 'Failed to parse response']);
  @override
  String toString() => 'ParseException: $message';
}

/// Thrown when a required field is missing or invalid
class ValidationException implements Exception {
  final String message;
  const ValidationException([this.message = 'Validation failed']);
  @override
  String toString() => 'ValidationException: $message';
}

/// Thrown when SignalR/WebSocket connection fails
class ConnectionException implements Exception {
  final String message;
  const ConnectionException([this.message = 'Connection failed']);
  @override
  String toString() => 'ConnectionException: $message';
}

// ── Error Handler ─────────────────────────────────────────────────

/// دالة لمعالجة أخطاء الـ API والشبكة وتحويلها لرسائل مفهومة للمستخدم
String handleError(dynamic e) {
  final msg = e.toString();

  // Specific exception types
  if (e is UnauthorizedException) return 'Session expired. Please login again.';
  if (e is NoInternetException) return 'No internet connection.';
  if (e is TimeoutException) return 'Request timed out. Please retry.';
  if (e is NotFoundException) return 'Data not found.';
  if (e is ServerException) return 'Server error. Please try later.';
  if (e is ParseException) return 'Failed to read server response.';
  if (e is ConnectionException) return 'Connection failed. Please retry.';

  // HTTP status codes from Dio
  if (msg.contains('400')) {
    if (msg.contains('already exists')) return 'This already exists.';
    if (msg.contains('digit')) return 'Password must contain a number.';
    return 'Invalid request. Please check your input.';
  }
  if (msg.contains('401')) return 'Session expired. Please login again.';
  if (msg.contains('403')) return 'Access denied.';
  if (msg.contains('404')) return 'Data not found.';
  if (msg.contains('409')) return 'This already exists.';
  if (msg.contains('422')) return 'Invalid data. Please check your input.';
  if (msg.contains('500') || msg.contains('503')) return 'Server error. Please try later.';

  // Network errors
  if (msg.contains('SocketException') || msg.contains('host lookup')) return 'Server unreachable. Check your connection.';
  if (msg.contains('timeout') || msg.contains('TimeoutException')) return 'Request timed out. Please retry.';
  if (msg.contains('connection refused') || msg.contains('127.0.0.1')) return 'Service temporarily unavailable.';
  if (msg.contains('certificate') || msg.contains('SSL')) return 'Secure connection failed.';

  return 'Something went wrong. Please try again.';
}

// ── App Error Screen ──────────────────────────────────────────────

/// شاشة مخصصة تظهر عند حدوث خطأ غير متوقع في التطبيق بدلاً من الشاشة الحمراء التقليدية
class AppErrorScreen extends StatelessWidget {
  final FlutterErrorDetails details;

  const AppErrorScreen({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    // أخذ السطر الأول فقط من الخطأ لتجنب عرض الـ Stack Trace كامل على الشاشة
    final summary = details.exceptionAsString().split('\n').first;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFFF8F0FF),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // أيقونة خطأ مميزة
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFE4E4),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.bug_report_outlined,
                      size: 52,
                      color: Color(0xFFE53E3E),
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    'Something went wrong',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A202C),
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'An unexpected error occurred.\nPlease restart the app.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFF718096),
                      height: 1.6,
                    ),
                  ),

                  // ✅ تم الإصلاح: تظهر تفاصيل الخطأ للمطور فقط في طور الـ Debug Mode
                  if (kDebugMode)
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFFFC8181),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          summary,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFFE53E3E),
                            fontFamily: 'monospace',
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

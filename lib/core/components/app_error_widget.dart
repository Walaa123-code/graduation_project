import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

/// Converts any raw Dio / server error string into a short, readable message.
String friendlyErrorMessage(String raw) {
  if (raw.contains('404')) return "Data not found on server.";
  if (raw.contains('401')) return "Session expired. Please login again.";
  if (raw.contains('403')) return "You don't have permission.";
  if (raw.contains('500')) return "Server error. Please try later.";
  if (raw.contains('SocketException') ||
      raw.contains('host lookup') ||
      raw.contains('No Internet')) return "No internet connection.";
  if (raw.contains('timeout')) return "Request timed out. Please retry.";
  if (raw.length < 80) return raw;
  return "Something went wrong. Please try again.";
}

/// A reusable, clean error state widget used across all screens.
class AppErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final IconData icon;
  final String title;

  const AppErrorWidget({
    super.key,
    required this.message,
    this.onRetry,
    this.icon = Icons.wifi_off_rounded,
    this.title = "Oops!",
  });

  @override
  Widget build(BuildContext context) {
    final friendly = friendlyErrorMessage(message);

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 50, color: Colors.red.shade300),
            ),

            const SizedBox(height: 20),

            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A202C),
              ),
            ),

            const SizedBox(height: 10),

            Text(
              friendly,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF718096),
                height: 1.5,
              ),
            ),

            if (onRetry != null) ...[
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh_rounded, color: Colors.white),
                  label: const Text(
                    "Try Again",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.lavenderColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

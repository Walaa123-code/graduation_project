import 'package:flutter/material.dart';

/// الجزء العلوي المشترك في Auth screens (logo + title + subtitle)
class AuthHeaderSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool showBackButton;

  const AuthHeaderSection({
    super.key,
    required this.title,
    required this.subtitle,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, showBackButton ? 12 : 20, 20, 12),      child: Column(
        children: [
          if (showBackButton) ...[
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.arrow_back_ios,
                      color: Colors.white, size: 18),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],

          // Logo circle
          Container(
            width: 72,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
              border: Border.all(
                  color: Colors.white.withValues(alpha: 0.4), width: 2),
            ),
            child: const Icon(Icons.self_improvement,
                size: 55, color: Colors.white),
          ),

          const SizedBox(height: 20),

          Text(
            title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),


          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withValues(alpha: 0.8),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

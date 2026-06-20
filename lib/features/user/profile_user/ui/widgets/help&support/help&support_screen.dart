import 'package:flutter/material.dart';
import 'package:mindecho/core/utils/app_colors.dart';
import 'package:mindecho/core/utils/app_styles.dart';

import 'contact_support_card.dart';
import 'emergency_warning_card.dart';
import 'faq_expansion_tile.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Help & Support", style: AppStyles.bold24Black),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 1️⃣ سيكشن الدعم المباشر
          Text("How can we help you?", style: AppStyles.bold20Black),
          const SizedBox(height: 12),

          ContactSupportCard(
            icon: Icons.email_outlined,
            title: "Email Support",
            subtitle: "Send us your query anytime",
            trailingText: "support@mindecho.com",
            onTap: () {},
          ),
          ContactSupportCard(
            icon: Icons.chat_bubble_outline,
            title: "MINDECHO Chatbot",
            subtitle: "Talk to our AI helper instantly",
            trailingText: "Open Chat",
            onTap: () {},
          ),

          const SizedBox(height: 24),

          Text("Frequently Asked Questions", style: AppStyles.bold18Black),
          const SizedBox(height: 12),

          const FaqExpansionTile(
            question: "What is MINDECHO?",
            answer: "MINDECHO is your personal wellness space designed to help you track your mood, practice journaling, and connect with psychological support tools.",
          ),
          const FaqExpansionTile(
            question: "Is my personal data safe?",
            answer: "Yes, completely. Your journals, mood logs, and personal details are encrypted and entirely private to you.",
          ),
          const FaqExpansionTile(
            question: "How does mood tracking work?",
            answer: "You can log your mood daily through the home screen, and MINDECHO will analyze your insights over time to show you patterns in your well-being.",
          ),
          const FaqExpansionTile(
            question: "How can I book a session?",
            answer: "Go to the Bookings section, select your preferred mental health specialist, pick a suitable time slot, and confirm your booking.",
          ),

          const SizedBox(height: 30),

          const EmergencyWarningCard(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
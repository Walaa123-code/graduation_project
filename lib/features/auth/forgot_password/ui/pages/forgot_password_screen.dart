import 'package:flutter/material.dart';
import 'package:mindecho/core/theme/app_colors.dart';
import 'package:mindecho/core/utils/app_theme.dart';
import 'package:mindecho/core/components/custom_text_field.dart';
import 'package:mindecho/core/components/custom_button.dart';

import 'package:mindecho/core/utils/app_colors.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      // Backend endpoint is not ready yet.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Forgot Password functionality is pending backend integration.'),
          backgroundColor: AppColors.purpleSoft,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.gray800,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.spacingLg),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppTheme.spacing2xl),
                const Icon(
                  Icons.lock_reset_outlined,
                  size: 64,
                  color: AppColors.purpleSoft,
                ),
                const SizedBox(height: AppTheme.spacingLg),
                const Text(
                  'Reset Your Password',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.gray800,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingMd),
                const Text(
                  'Enter your email address and we will send you instructions to reset your password.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.gray500,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingXl),
                CustomTextField(
                  hintText: 'Email Address',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppTheme.spacingXl),
                CustomButton(
                  text: 'Send Reset Link',
                  onPressed: _handleSubmit,
                  width: double.infinity,
                  backgroundColor: AppColors.purpleSoft,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

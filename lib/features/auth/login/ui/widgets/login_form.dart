import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/core/utils/app_colors.dart';
import 'package:mindecho/core/components/custom_text_field.dart';
import 'package:mindecho/core/components/auth_gradient_button.dart';
import 'package:mindecho/core/components/auth_bottom_link.dart';
import '../../../forgot_password/ui/pages/forgot_password_screen.dart';
import 'role_toggle.dart';

/// الفورم الكامل لشاشة الـ Login داخل الـ white card
class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isDoctorLogin;
  final bool isLoading;
  final ValueChanged<bool> onRoleChanged;
  final VoidCallback onLogin;
  final VoidCallback onNavigateToRegister;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.isDoctorLogin,
    required this.isLoading,
    required this.onRoleChanged,
    required this.onLogin,
    required this.onNavigateToRegister,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(28, 32, 28, 28),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RoleToggle(
              isDoctorSelected: isDoctorLogin,
              onChanged: onRoleChanged,
            ),

            const SizedBox(height: 28),

            CustomTextField(
              hintText: 'Email Address',
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: const Icon(Icons.email_outlined,
                  color: AppColors.purpleSoft, size: 20),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Please enter your email';
                if (!v.contains('@')) return 'Invalid email';
                return null;
              },
            ),

            const SizedBox(height: 16),

            CustomTextField(
              hintText: 'Password',
              controller: passwordController,
              isPassword: true,
              prefixIcon: const Icon(Icons.lock_outline,
                  color: AppColors.purpleSoft, size: 20),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Please enter your password';
                return null;
              },
            ),

            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (_) => const ForgotPasswordScreen()),
                ),
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.purpleSoft,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),

            AuthGradientButton(
              text: isLoading ? 'Signing in...' : 'Sign In',
              isLoading: isLoading,
              onTap: isLoading ? null : onLogin,
            ),

            const SizedBox(height: 28),

            AuthBottomLink(
              message: "Don't have an account?",
              linkText: 'Create Account',
              onTap: onNavigateToRegister,
            ),
          ],
        ),
      ),
    );
  }
}

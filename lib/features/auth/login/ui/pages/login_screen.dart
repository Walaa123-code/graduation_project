import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/components/custom_text_field.dart';
import '../../../../../core/components/custom_button.dart';
import '../../../ui/pages/user_register_screen.dart';

/// Login Screen
/// Welcome back screen for existing users
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement real login logic
      // Mock login for doctor
      final email = _emailController.text.toLowerCase();
      if (email.contains('doctor') || email == 'wafaasakr044@gmail.com') {
        Navigator.pushReplacementNamed(context, '/doctor/main');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Logged in as user (Home not implemented yet)'),
            backgroundColor: AppColors.purpleSoft,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.spacingLg),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppTheme.spacing2xl),

                // Title
                const Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: AppColors.purpleSoft, // Changed to Purple
                    letterSpacing: -0.5,
                  ),
                ),

                const SizedBox(height: AppTheme.spacingXl),

                // Email Field
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

                const SizedBox(height: AppTheme.spacingMd),

                // Password Field
                CustomTextField(
                  hintText: 'Password',
                  controller: _passwordController,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: AppTheme.spacingSm),

                // Forgot Password Link
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // TODO: Implement forgot password
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.purpleSoft, // Changed to Purple
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: AppTheme.spacingLg),

                // Login Button
                CustomButton(
                  text: 'Login',
                  onPressed: _handleLogin,
                  width: double.infinity,
                  backgroundColor: AppColors.purpleSoft,
                ),

                const SizedBox(height: AppTheme.spacingLg),

                // Register Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'New here? ',
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.gray500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const UserRegisterScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Register now',
                        style: TextStyle(
                          fontSize: 15,
                          color: AppColors.purpleSoft, // Changed to Purple
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

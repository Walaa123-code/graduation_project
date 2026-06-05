import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/components/custom_text_field.dart';
import '../../../../core/components/custom_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../auth/login/ui/widgets/auth_header.dart';
import '../../../auth/login/ui/widgets/login_link_row.dart';

class DoctorRegisterScreen extends StatefulWidget {
  const DoctorRegisterScreen({super.key});

  @override
  State<DoctorRegisterScreen> createState() => _DoctorRegisterScreenState();
}

class _DoctorRegisterScreenState extends State<DoctorRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _specialtyController = TextEditingController();
  final _licenseController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _specialtyController.dispose();
    _licenseController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement doctor registration logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Doctor registration successful!'),
          backgroundColor: AppColors.purpleSoft,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.purpleSoft),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 8),

                // Icon
                Center(
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: AppColors.purpleSoft.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.medical_services_outlined,
                        size: 36, color: AppColors.purpleSoft),
                  ),
                ),

                const SizedBox(height: 20),

                const AuthHeader(
                  title: 'Join Us as a Doctor',
                  subtitle: 'Create your doctor account and start helping patients',
                ),

                const SizedBox(height: 28),

                CustomTextField(
                  hintText: 'Full Name',
                  controller: _nameController,
                  prefixIcon: const Icon(Icons.person_outline, color: AppColors.gray400),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Please enter your full name';
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  hintText: 'Email Address',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.email_outlined, color: AppColors.gray400),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Please enter your email';
                    if (!v.contains('@')) return 'Please enter a valid email';
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  hintText: 'Password',
                  controller: _passwordController,
                  isPassword: true,
                  prefixIcon: const Icon(Icons.lock_outline, color: AppColors.gray400),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Please enter a password';
                    if (v.length < 6) return 'Password must be at least 6 characters';
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  hintText: 'Confirm Password',
                  controller: _confirmPasswordController,
                  isPassword: true,
                  prefixIcon: const Icon(Icons.lock_outline, color: AppColors.gray400),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Please confirm your password';
                    if (v != _passwordController.text) return 'Passwords do not match';
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  hintText: 'Specialty',
                  controller: _specialtyController,
                  prefixIcon: const Icon(Icons.psychology_outlined, color: AppColors.gray400),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Please enter your specialty';
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  hintText: 'License Number',
                  controller: _licenseController,
                  prefixIcon: const Icon(Icons.badge_outlined, color: AppColors.gray400),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Please enter your license number';
                    return null;
                  },
                ),

                const SizedBox(height: 28),

                CustomButton(
                  text: 'Create Doctor Account',
                  onPressed: _handleRegister,
                  width: double.infinity,
                  backgroundColor: AppColors.purpleSoft,
                ),

                const SizedBox(height: 24),
                const LoginLinkRow(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

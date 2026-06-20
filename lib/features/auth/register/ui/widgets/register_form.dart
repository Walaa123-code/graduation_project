import 'package:flutter/material.dart';
import 'package:mindecho/core/utils/app_colors.dart';
import 'package:mindecho/core/components/custom_text_field.dart';
import 'package:mindecho/core/components/auth_gradient_button.dart';
import 'package:mindecho/core/components/auth_bottom_link.dart';

class RegisterForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController ageController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  final String? selectedGender;
  final ValueChanged<String?> onGenderChanged;

  final bool isLoading;
  final VoidCallback onRegister;
  final VoidCallback onNavigateToLogin;

  const RegisterForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.ageController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.selectedGender,
    required this.onGenderChanged,
    required this.isLoading,
    required this.onRegister,
    required this.onNavigateToLogin,
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
            CustomTextField(
              hintText: 'Full Name',
              controller: nameController,
              prefixIcon: const Icon(
                Icons.person_outline,
                color: AppColors.purpleSoft,
                size: 20,
              ),
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return 'Please enter your full name';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            CustomTextField(
              hintText: 'Email Address',
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: const Icon(
                Icons.email_outlined,
                color: AppColors.purpleSoft,
                size: 20,
              ),
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return 'Please enter your email';
                }

                if (!v.contains('@')) {
                  return 'Invalid email';
                }

                return null;
              },
            ),



            const SizedBox(height: 16),


            CustomTextField(
              hintText: 'Password',
              controller: passwordController,
              isPassword: true,
              prefixIcon: const Icon(
                Icons.lock_outline,
                color: AppColors.purpleSoft,
                size: 20,
              ),
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return 'Please enter a password';
                }

                if (v.length < 6) {
                  return 'Min 6 characters';
                }

                if (!v.contains(RegExp(r'[0-9]'))) {
                  return 'Must contain at least one number';
                }

                return null;
              },
            ),

            const SizedBox(height: 16),

            CustomTextField(
              hintText: 'Confirm Password',
              controller: confirmPasswordController,
              isPassword: true,
              prefixIcon: const Icon(
                Icons.lock_outline,
                color: AppColors.purpleSoft,
                size: 20,
              ),
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return 'Please confirm password';
                }

                if (v != passwordController.text) {
                  return 'Passwords do not match';
                }

                return null;
              },
            ),
            const SizedBox(height: 16),


            CustomTextField(
              hintText: 'Age [25-100]',
              controller: ageController,
              keyboardType: TextInputType.number,
              prefixIcon: const Icon(
                Icons.cake_outlined,
                color: AppColors.purpleSoft,
                size: 20,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter age';
                }

                final age = int.tryParse(value);

                if (age == null) {
                  return 'Enter valid age';
                }

                if (age < 25 || age > 100) {
                  return 'Age must be between 25 and 100';
                }

                return null;
              },
            ),

            const SizedBox(height: 16),


            DropdownButtonFormField<String>(
              value: selectedGender,
              decoration: InputDecoration(
                hintText: "Select Gender",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              items: const [
                DropdownMenuItem(
                  value: "Male",
                  child: Text("Male"),
                ),
                DropdownMenuItem(
                  value: "Female",
                  child: Text("Female"),
                ),
              ],
              onChanged: onGenderChanged,
              validator: (value) {
                if (value == null) {
                  return 'Please select gender';
                }
                return null;
              },
            ),
            const SizedBox(height: 32),

            AuthGradientButton(
              text: isLoading ? 'Creating...' : 'Create Account',
              isLoading: isLoading,
              onTap: isLoading ? null : onRegister,
            ),

            const SizedBox(height: 25),

            AuthBottomLink(
              message: 'Already have an account?',
              linkText: 'Sign In',
              onTap: onNavigateToLogin,
            ),

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
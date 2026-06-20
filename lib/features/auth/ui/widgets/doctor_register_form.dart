import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/core/components/custom_button.dart';
import 'package:mindecho/core/components/custom_text_field.dart';
import 'package:mindecho/core/theme/app_colors.dart';
import 'package:mindecho/core/utils/app_theme.dart';
import 'package:mindecho/features/auth/login/ui/pages/login_screen.dart';
import 'package:mindecho/features/auth/ui/manager/auth_cubit.dart';
import 'package:mindecho/features/auth/ui/widgets/gender_dropdown.dart';
import 'package:mindecho/features/auth/ui/widgets/register_header.dart';

import 'package:mindecho/core/utils/app_colors.dart';

class DoctorRegisterForm extends StatefulWidget {
  const DoctorRegisterForm({super.key});

  @override
  State<DoctorRegisterForm> createState() => _DoctorRegisterFormState();
}

class _DoctorRegisterFormState extends State<DoctorRegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _specialtyController = TextEditingController();
  final _licenseController = TextEditingController();
  final _ageController = TextEditingController();
  final _bioController = TextEditingController();
  int _selectedGender = 0;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _specialtyController.dispose();
    _licenseController.dispose();
    _ageController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().registerDoctor(
            fullName: _nameController.text,
            email: _emailController.text,
            password: _passwordController.text,
            gender: _selectedGender,
            age: int.parse(_ageController.text),
            licenseNumber: _licenseController.text,
            specialization: _specialtyController.text,
            bio: _bioController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Doctor registration successful!'),
              backgroundColor: AppColors.purpleSoft,
            ),
          );
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        } else if (state is AuthErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.failure.errors ?? 'An error occurred'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        final bool isLoading = state is AuthLoadingState;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.spacingLg),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const RegisterHeader(),

                // Full Name Field
                CustomTextField(
                  hintText: 'Full Name',
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: AppTheme.spacingMd),

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
                  hintText: 'Password (min 6 chars, 1 uppercase, 1 special)',
                  controller: _passwordController,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    if (!value.contains(RegExp(r'[A-Z]'))) {
                      return 'Password must contain an uppercase letter';
                    }
                    if (!value.contains(RegExp(r'[^a-zA-Z0-9]'))) {
                      return 'Password must contain a special character';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: AppTheme.spacingMd),

                // Confirm Password Field
                CustomTextField(
                  hintText: 'Confirm Password',
                  controller: _confirmPasswordController,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: AppTheme.spacingMd),

                // Specialty Field
                CustomTextField(
                  hintText: 'Specialty',
                  controller: _specialtyController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your specialty';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: AppTheme.spacingMd),

                // License Number Field
                CustomTextField(
                  hintText: 'License Number',
                  controller: _licenseController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your license number';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: AppTheme.spacingMd),

                // Bio Field
                CustomTextField(
                  hintText: 'Bio (Optional)',
                  controller: _bioController,
                  validator: (value) {
                    return null;
                  },
                ),

                const SizedBox(height: AppTheme.spacingMd),

                // Age Field
                CustomTextField(
                  hintText: 'Age (25 - 100)',
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your age';
                    }
                    final age = int.tryParse(value);
                    if (age == null) {
                      return 'Please enter a valid number';
                    }
                    if (age < 25 || age > 100) {
                      return 'Age must be between 25 and 100';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: AppTheme.spacingMd),

                // Gender Selection
                GenderDropdown(
                  value: _selectedGender,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                ),

                const SizedBox(height: AppTheme.spacingXl),

                // Create Doctor Account Button
                CustomButton(
                  text: isLoading ? 'Loading...' : 'Create Doctor Account',
                  onPressed: isLoading ? () {} : _handleRegister,
                  width: double.infinity,
                ),

                const SizedBox(height: AppTheme.spacingLg),

                // Login Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account? ',
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.gray500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 15,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

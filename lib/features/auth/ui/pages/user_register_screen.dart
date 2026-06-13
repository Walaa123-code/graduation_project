import 'package:flutter/material.dart';
import 'package:mindecho/core/theme/app_colors.dart';
import 'package:mindecho/core/theme/app_theme.dart';
import '../../../../core/components/custom_text_field.dart';
import 'package:mindecho/core/components/custom_button.dart';
import '../../login/ui/pages/login_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../manager/auth_cubit.dart';

/// User Registration Screen
/// Create account for users seeking mental health support
class UserRegisterScreen extends StatefulWidget {
  const UserRegisterScreen({super.key});

  @override
  State<UserRegisterScreen> createState() => _UserRegisterScreenState();
}

class _UserRegisterScreenState extends State<UserRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _ageController = TextEditingController();
  int _selectedGender = 0;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().registerUser(
        fullName: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        gender: _selectedGender,
        age: int.parse(_ageController.text),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Registration successful!'),
                  backgroundColor: AppColors.primary,
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
            bool isLoading = state is AuthLoadingState;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(AppTheme.spacingLg),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppTheme.spacingXl),

                // Title
                const Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: AppColors.gray800,
                    letterSpacing: -0.5,
                  ),
                ),

                const SizedBox(height: AppTheme.spacingSm),

                // Subtitle
                const Text(
                  'Join MINDECHO and start your wellness journey',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.gray500,
                  ),
                ),

                const SizedBox(height: AppTheme.spacingXl),

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
                DropdownButtonFormField<int>(
                  initialValue: _selectedGender,
                  decoration: InputDecoration(
                    labelText: 'Gender',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.gray200),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.gray200),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.primary),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                  items: const [
                    DropdownMenuItem(value: 0, child: Text('Male')),
                    DropdownMenuItem(value: 1, child: Text('Female')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value!;
                    });
                  },
                ),

                const SizedBox(height: AppTheme.spacingXl),

                // Create Account Button
                CustomButton(
                  text: isLoading ? 'Loading...' : 'Create Account',
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
      ),
      ),
    );
  }
}

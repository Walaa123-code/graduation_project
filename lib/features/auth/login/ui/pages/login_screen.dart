import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/components/custom_text_field.dart';
import '../../../../../core/components/custom_button.dart';
import '../../../ui/pages/user_register_screen.dart';
import '../../../ui/pages/doctor_register_screen.dart';
import '../../../forgot_password/ui/pages/forgot_password_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../ui/manager/auth_cubit.dart';

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
  bool _isDoctorLogin = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;
      if (_isDoctorLogin) {
        context.read<AuthCubit>().loginDoctor(email: email, password: password);
      } else {
        context.read<AuthCubit>().loginUser(email: email, password: password);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccessState) {
              if (_isDoctorLogin) {
                Navigator.pushReplacementNamed(context, '/doctor/main');
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Logged in as user (Home not implemented yet)'),
                    backgroundColor: AppColors.purpleSoft,
                  ),
                );
              }
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

                // Role Toggle
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.gray200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _isDoctorLogin = false),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: !_isDoctorLogin ? Colors.white : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: !_isDoctorLogin
                                  ? [const BoxShadow(color: Colors.black12, blurRadius: 4)]
                                  : null,
                            ),
                            child: const Center(
                              child: Text(
                                'User',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _isDoctorLogin = true),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: _isDoctorLogin ? Colors.white : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: _isDoctorLogin
                                  ? [const BoxShadow(color: Colors.black12, blurRadius: 4)]
                                  : null,
                            ),
                            child: const Center(
                              child: Text(
                                'Doctor',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordScreen(),
                        ),
                      );
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
                  text: isLoading ? 'Logging in...' : 'Login',
                  onPressed: isLoading ? () {} : _handleLogin,
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
                        if (_isDoctorLogin) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const DoctorRegisterScreen(),
                            ),
                          );
                        } else {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const UserRegisterScreen(),
                            ),
                          );
                        }
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
        );
        },
      ),
      ),
    );
  }
}

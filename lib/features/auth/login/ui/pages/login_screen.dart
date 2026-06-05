import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/components/custom_text_field.dart';
import '../../../../../core/components/custom_button.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../di/di.dart';
import '../../../register/ui/pages/register_screen.dart';
import '../manager/cubit/login_cubit.dart';
import '../widgets/auth_header.dart';
import '../widgets/register_link_row.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final LoginCubit _loginCubit = getIt<LoginCubit>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _loginCubit,
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            final doctorId = state.loginResponseEntity.data?.doctorId;
            if (doctorId != null) {
              Navigator.pushReplacementNamed(context, '/doctor/main');
            } else {
              Navigator.pushReplacementNamed(context, 'home_screen');
            }
          }
          if (state is LoginErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.failures.errors),
              backgroundColor: Colors.red,
            ));
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 48),

                    // Logo
                    Center(
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: AppColors.purpleSoft.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.self_improvement,
                          size: 44,
                          color: AppColors.purpleSoft,
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    const AuthHeader(
                      title: 'Welcome Back',
                      subtitle: 'Sign in to continue your wellness journey',
                      titleColor: AppColors.purpleSoft,
                    ),

                    const SizedBox(height: 35),

                    CustomTextField(
                      hintText: 'Email Address',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const Icon(Icons.email_outlined,
                          color: AppColors.gray400),
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
                      prefixIcon: const Icon(Icons.lock_outline,
                          color: AppColors.gray400),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Please enter your password';
                        return null;
                      },
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text('Forgot Password?',
                            style: TextStyle(
                                fontSize: 14,
                                color: AppColors.purpleSoft,
                                fontWeight: FontWeight.w500)),
                      ),
                    ),

                    const SizedBox(height: 8),

                    BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {
                        if (state is LoginLoadingState) {
                          return const Center(
                              child: CircularProgressIndicator(
                                  color: AppColors.purpleSoft));
                        }
                        return CustomButton(
                          text: 'Login',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _loginCubit.login(
                                _emailController.text.trim(),
                                _passwordController.text.trim(),
                              );
                            }
                          },
                          width: double.infinity,
                          backgroundColor: AppColors.purpleSoft,
                        );
                      },
                    ),

                    const SizedBox(height: 24),
                    const RegisterLinkRow(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

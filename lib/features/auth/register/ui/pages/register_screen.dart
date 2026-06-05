import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/components/custom_text_field.dart';
import '../../../../../core/components/custom_button.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../di/di.dart';
import '../manager/cubit/register_cubit.dart';
import '../../../login/ui/widgets/auth_header.dart';
import '../../../login/ui/widgets/login_link_row.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final RegisterCubit _registerCubit = getIt<RegisterCubit>();
  final ImagePicker _picker = ImagePicker();
  File? _profileImage;

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (picked != null) {
      setState(() => _profileImage = File(picked.path));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _registerCubit,
      child: BlocListener<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterSuccessState) {
              Navigator.pushReplacementNamed(context, 'home_screen');
            }
            if (state is RegisterErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.failures.errors),
                backgroundColor: Colors.red,
              ));
            }
          },
          child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios,
                    color: AppColors.purpleSoft),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const AuthHeader(
                      title: 'Create Account',
                      subtitle:
                          'Join MINDECHO and start your wellness journey',
                    ),

                    const SizedBox(height: 28),





                    const SizedBox(height: 24),
                    CustomTextField(
                      hintText: 'Full Name',
                      controller: _nameController,
                      prefixIcon: const Icon(Icons.person_outline,
                          color: AppColors.gray400),
                      validator: (v) {
                        if (v == null || v.isEmpty)
                          return 'Please enter your full name';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      hintText: 'Email Address',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const Icon(Icons.email_outlined,
                          color: AppColors.gray400),
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!v.contains('@')) {
                          return 'Please enter a valid email';
                        }
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
                        if (v == null || v.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (v.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      hintText: 'Confirm Password',
                      controller: _confirmPasswordController,
                      isPassword: true,
                      prefixIcon: const Icon(Icons.lock_outline,
                          color: AppColors.gray400),
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (v != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 28),

                    BlocBuilder<RegisterCubit, RegisterState>(
                      builder: (context, state) {
                        if (state is RegisterLoadingState) {
                          return const Center(
                              child: CircularProgressIndicator(
                                  color: AppColors.purpleSoft));
                        }
                        return CustomButton(
                          text: 'Create Account',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _registerCubit.register(
                                _nameController.text.trim(),
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
                    const LoginLinkRow(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

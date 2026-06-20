import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/core/components/auth_background.dart';
import 'package:mindecho/core/components/auth_header_section.dart';
import 'package:mindecho/core/utils/app_colors.dart';
import 'package:mindecho/di/di.dart';
import '../manager/cubit/register_cubit.dart';
import '../../../login/ui/pages/login_screen.dart';
import '../widgets/register_form.dart';

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
  final _ageController = TextEditingController();
  String? selectedGender;
  final RegisterCubit _registerCubit = getIt<RegisterCubit>();

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
      _registerCubit.register(
        _nameController.text.trim(),
        _emailController.text.trim(),
        _passwordController.text.trim(),
        int.parse(_ageController.text.trim()),
        selectedGender!,
      );
    }

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
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ));
          }
        },
        child: Scaffold(
          body: Expanded(
            child: Stack(
              children: [
                const AuthBackground(),
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Column(
                    children: [
                      const AuthHeaderSection(
                        title: 'Create Account',
                        subtitle:
                            'Join MINDECHO and start your wellness journey',
                        showBackButton: true,
                      ),
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(

                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(32)),
                          ),
                          child: BlocBuilder<RegisterCubit, RegisterState>(
                            builder: (context, state) {
                              return RegisterForm(
                                ageController: _ageController,
                                selectedGender: selectedGender,
                                onGenderChanged: (value) {
                                  setState(() {
                                    selectedGender = value;
                                  });
                                },
                                formKey: _formKey,
                                nameController: _nameController,
                                emailController: _emailController,
                                passwordController: _passwordController,
                                confirmPasswordController:
                                    _confirmPasswordController,
                                isLoading: state is RegisterLoadingState,
                                onRegister: _handleRegister,
                                onNavigateToLogin: () =>
                                    Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (_) => const LoginScreen()),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

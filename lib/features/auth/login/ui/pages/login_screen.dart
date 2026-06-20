import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/core/components/auth_background.dart';
import 'package:mindecho/core/components/auth_header_section.dart';
import '../../../../auth/ui/manager/auth_cubit.dart';
import '../../../../auth/ui/pages/doctor_register_screen.dart';
import '../../../register/ui/pages/register_screen.dart';
import '../widgets/login_form.dart';

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
      if (_isDoctorLogin) {
        context.read<AuthCubit>().loginDoctor(
              email: _emailController.text,
              password: _passwordController.text,
            );
      } else {
        context.read<AuthCubit>().loginUser(
              email: _emailController.text,
              password: _passwordController.text,
            );
      }
    }
  }

  void _navigateToRegister() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => _isDoctorLogin
            ? const DoctorRegisterScreen()
            : const RegisterScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccessState) {
            Navigator.pushReplacementNamed(
              context,
              _isDoctorLogin ? '/doctor/main' : 'home_screen',
            );
          } else if (state is AuthErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.failure.errors ?? 'An error occurred'),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ));
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoadingState;
          return Stack(
            children: [
              const AuthBackground(),
              SafeArea(
                child: Column(
                  children: [
                    const AuthHeaderSection(
                      title: 'Welcome Back',
                      subtitle: 'Sign in to continue your wellness journey',
                    ),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(32)),
                        ),
                        child: LoginForm(
                          formKey: _formKey,
                          emailController: _emailController,
                          passwordController: _passwordController,
                          isDoctorLogin: _isDoctorLogin,
                          isLoading: isLoading,
                          onRoleChanged: (v) =>
                              setState(() => _isDoctorLogin = v),
                          onLogin: _handleLogin,
                          onNavigateToRegister: _navigateToRegister,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

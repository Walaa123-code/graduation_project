import 'package:flutter/material.dart';
import '../features/onboarding/ui/pages/splash_screen.dart';
import '../features/onboarding/ui/pages/onboarding_screen.dart';
import '../features/auth/ui/pages/account_type_screen.dart';
import '../features/auth/ui/pages/user_register_screen.dart';
import '../features/auth/ui/pages/doctor_register_screen.dart';
import '../features/auth/login/ui/pages/login_screen.dart';
import '../features/doctor/main/pages/doctor_main_screen.dart';
import '../features/doctor/patients/pages/patients_screen.dart';
import '../features/doctor/appointments/pages/appointments_screen.dart';
import '../features/doctor/messages/pages/messages_screen.dart';
import '../features/doctor/reports/pages/reports_screen.dart';

class Routes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String accountType = '/account-type';
  static const String userRegister = '/register/user';
  static const String doctorRegister = '/register/doctor';
  static const String login = '/login';
  static const String doctorMain = '/doctor/main';
  static const String patientsList = '/doctor/patients';
  static const String appointments = '/doctor/appointments';
  static const String messages = '/doctor/messages';
  static const String reports = '/doctor/reports';
}

class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case Routes.onboarding:
        return MaterialPageRoute(
            builder: (context) => const OnboardingScreen());
      case Routes.accountType:
        return MaterialPageRoute(
            builder: (context) => const AccountTypeScreen());
      case Routes.userRegister:
        return MaterialPageRoute(
            builder: (context) => const UserRegisterScreen());
      case Routes.doctorRegister:
        return MaterialPageRoute(
            builder: (context) => const DoctorRegisterScreen());
      case Routes.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case Routes.doctorMain:
        return MaterialPageRoute(
            builder: (context) => const DoctorMainScreen());
      case Routes.patientsList:
        return MaterialPageRoute(builder: (context) => const PatientsScreen());
      case Routes.appointments:
        return MaterialPageRoute(
            builder: (context) => const AppointmentsScreen());
      case Routes.messages:
        return MaterialPageRoute(builder: (context) => const MessagesScreen());
      case Routes.reports:
        return MaterialPageRoute(builder: (context) => const ReportsScreen());
      default:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
    }
  }
}

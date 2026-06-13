import 'package:flutter/material.dart';
import '../features/auth/register/ui/widgets/doctor_register_screen.dart';
import '../features/home/home_screen.dart';
import '../features/onboarding/ui/pages/splash_screen.dart';
import '../features/onboarding/ui/pages/onboarding_screen.dart';
import '../features/auth/register/ui/widgets/account_type_screen.dart';
import '../features/auth/register/ui/pages/register_screen.dart';
import '../features/auth/login/ui/pages/login_screen.dart';
import '../features/Doctor/ui/pages/main/pages/doctor_main_screen.dart';
import '../features/Doctor/ui/pages/patients/pages/patients_screen.dart';
import '../features/Doctor/ui/pages/appointments/pages/appointments_screen.dart';
import '../features/Doctor/ui/pages/messages/pages/messages_screen.dart';
import '../features/Doctor/ui/pages/reports/pages/reports_screen.dart';

class Routes {
  static const String homeScreenRoutes = "home_screen";
  static const String homeTabRoutes = "home_tab";
  static const String libraryRoutes = "library_screen";
  static const String mySpaceRoutes = "my_space_screen";
  static const String appointmentsRoutes = "appointments_screen";
  static const String profileRoutes = "profile_screen";
  static const String journalDetailsRoutes = "journal_details";
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
      case Routes.homeScreenRoutes:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
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
            builder: (context) => const RegisterScreen());
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

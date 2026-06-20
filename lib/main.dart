import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/app_routes.dart';
import 'package:mindecho/core/utils/app_theme.dart';
import 'core/errors/exceptions.dart';
import 'core/utils/my_bloc_observar.dart';
import 'core/cashe/shared_preferences_utils.dart';
import 'package:mindecho/di/di.dart';
import 'package:mindecho/features/Doctor/ui/manager/doctor_cubit.dart';
import 'package:mindecho/features/Doctor/ui/manager/schedule_cubit.dart';
import 'features/auth/ui/manager/auth_cubit.dart';
import 'features/user/appointments/ui/manager/booking_cubit.dart';
import 'features/user/home_tab/ui/manager/mood_cubit.dart';
import 'features/user/profile_user/ui/manager/notification_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ── Must init before anything else ─────────────────────────────
  await SharedPreferencesUtils.init();

  ErrorWidget.builder = (FlutterErrorDetails details) {
    return AppErrorScreen(details: details);
  };

  try {
    await initAppModule();
  } catch (e, stack) {
    debugPrint('❌ initAppModule failed: $e');
    debugPrint('$stack');
  }

  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<MoodCubit>()),
        BlocProvider(create: (context) => getIt<AuthCubit>()),
        BlocProvider(create: (context) => getIt<DoctorCubit>()),
        BlocProvider(create: (context) => getIt<ScheduleCubit>()),
        BlocProvider(create: (context) => getIt<BookingCubit>()),
        BlocProvider(create: (context) => getIt<NotificationCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MINDECHO',
        theme: AppTheme.lightTheme,
        onGenerateRoute: AppRoutes.onGenerateRoute,
        initialRoute: Routes.splash,
      ),
    );
  }
}

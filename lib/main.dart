import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/app_routes.dart';
import 'core/cashe/shared_preferences_utils.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/my_bloc_observar.dart';
import 'di/di.dart';
import 'features/home_tab/ui/manager/mood_cubit.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPreferencesUtils.init();
  await initAppModule();

  await SharedPreferencesUtils.saveData(
      key: "token",
      value:"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6Ijc5ZWM2ZjBhLTc3MGUtNDMzOS1iZjFhLTFkNzU2NDJjYTNiYSIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6ImF5YUBleGFtcGxlLmNvbSIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6IlVzZXIiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiYXlhIiwiU2VuZGVyVHlwZSI6IjAiLCJqdGkiOiJiNWE3ZGFlOC00ZjM3LTRmNzMtOGFkZS1mMmVmZGU4YjAxYzMiLCJleHAiOjE3NzU3Nzk3MjYsImlzcyI6Imh0dHBzOi8vbG9jYWxob3N0OjcyMDAvIiwiYXVkIjoiTWluZEVhc2VDbGllbnQifQ.rg4ABnknH8NLEHcqRbdDrb2TsCy-3ZhZuk8nAfIseZM"
  );

  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<MoodCubit>(),
        ),
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

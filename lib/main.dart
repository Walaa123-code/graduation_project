import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/config/app_routes.dart';
import 'package:graduation_project/features/appointments/ui/pages/appointments_tab.dart';
import 'package:graduation_project/features/home/home_screen.dart';
import 'package:graduation_project/features/home_tab/ui/pages/home_tab.dart';
import 'package:graduation_project/features/libiraries/ui/pages/library_tab.dart';
import 'package:graduation_project/features/profile_user/ui/pages/profile_user_screen.dart';
import 'core/cashe/shared_preferences_utils.dart';
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
          // بنوفر الـ MoodCubit هنا عشان يكون متاح في كل التطبيق
          BlocProvider(
            create: (context) => getIt<MoodCubit>(),
          ),
          // لو عندك Cubits تانية زي الـ Profile مثلاً تقدري تضيفيها هنا
        ],
        child: const MaterialApp(
    debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      // initialRoute: AppRoutes.homeScreenRoutes,
      // routes: {
      // AppRoutes.homeScreenRoutes: (context)=> HomeScreen(),
      //   AppRoutes.homeTabRoutes: (context) => HomeTab(),
      //   AppRoutes.libraryRoutes: (context)=> LibrariesScreen(),
      //   AppRoutes.mySpaceRoutes: (context)=> MySpaceScreen(),
      //   AppRoutes.profileRoutes: (context)=> ProfileUserScreen(),
      // },
    ));
  }
}

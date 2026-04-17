import 'package:flutter/material.dart';
import 'package:graduation_project/config/app_routes.dart';
import 'package:graduation_project/features/appointments/ui/pages/appointments_tab.dart';
import 'package:graduation_project/features/home/home_screen.dart';
import 'package:graduation_project/features/home_tab/ui/pages/home_tab.dart';
import 'package:graduation_project/features/libiraries/ui/pages/library_tab.dart';
import 'package:graduation_project/features/my_space/ui/pages/my_space_screen.dart';
import 'package:graduation_project/features/profile_user/ui/pages/profile_user_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}

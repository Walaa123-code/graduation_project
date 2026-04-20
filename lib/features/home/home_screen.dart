import 'package:flutter/material.dart';
import 'package:graduation_project/features/appointments/ui/pages/appointments_tab.dart';
import 'package:graduation_project/features/home_tab/ui/pages/home_tab.dart';
import 'package:graduation_project/features/libiraries/ui/pages/library_tab.dart';
import 'package:graduation_project/features/my_space/ui/pages/my_space_screen.dart';
import 'package:graduation_project/features/profile_user/ui/pages/profile_user_screen.dart';
import '../../core/utils/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _TestState();
}

class _TestState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Widget> screen = [
     HomeTab(),
    const LibraryTab(),
    const MySpaceScreen(),
    const AppointmentsScreen(),
    const ProfileUserScreen(),
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(canvasColor: AppColors.whiteColor),
            child: BottomNavigationBar(
                elevation: 5,
                selectedItemColor: AppColors.lavenderColor,
                unselectedItemColor: AppColors.darkGrayColor,
                currentIndex: currentIndex,
                onTap: (index) {
                  currentIndex = index;
                  setState(() {});
                },
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home_outlined, size: 30), label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.menu_book_sharp, size: 30),
                      label: "Library"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.self_improvement, size: 30),
                      label: "My Space"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.calendar_month_sharp, size: 30),
                      label: "Appointments"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person_outline_sharp, size: 30),
                      label: "Profile"),
                ])),
        body: SafeArea(
          top: false,
          child: Stack(
            children: [
              screen[currentIndex],
            ],
          ),
        ));
  }
}

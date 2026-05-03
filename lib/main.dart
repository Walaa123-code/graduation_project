import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/my_bloc_observar.dart';
import 'di/di.dart';
import 'features/home_tab/ui/manager/mood_cubit.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();

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

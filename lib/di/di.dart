import 'package:get_it/get_it.dart';
import 'package:graduation_project/features/profile_user/data/repositories/profile_repository_impl.dart';
import 'package:graduation_project/features/profile_user/domain/repositories/data_source/remote_data_source/profile_remote_data_source.dart';
import 'package:graduation_project/features/profile_user/domain/repositories/repositories/profile_repository.dart';
import 'package:graduation_project/features/profile_user/domain/use_cases/profile_use_case.dart';
import '../core/api/api_manager.dart';
import '../features/home_tab/data/data_sources/remote_data_source_impl/mood_remote_data_source_impl.dart';
import '../features/home_tab/data/repositories/mood_repository_impl.dart';
import '../features/home_tab/domain/repositories/data_source/remote_data_source/mood_remote_data_source.dart';
import '../features/home_tab/domain/repositories/repositories/mood_repository.dart';
import '../features/home_tab/domain/use_cases/MoodUseCase.dart';
import '../features/home_tab/ui/manager/mood_cubit.dart';
import '../features/profile_user/data/data_source/remote_data_source_impl/profile_remote_data_source_impl.dart';
import '../features/profile_user/ui/manager/profile_cubit.dart';


final getIt = GetIt.instance;
Future<void> initAppModule() async {
  getIt.registerLazySingleton<ApiManager>(() => ApiManager());
  getIt.registerLazySingleton<ProfileRemoteDataSource>(
        () => ProfileRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<ProfileRepository>(
        () => ProfileRepositoryImpl(profileRemoteDataSource: getIt<ProfileRemoteDataSource>()),
  );
  getIt.registerLazySingleton<ProfileUseCase>(
        () => ProfileUseCase(profileRepository: getIt<ProfileRepository>()),
  );

getIt.registerFactory<ProfileCubit>(()=>ProfileCubit(profileUseCase: getIt<ProfileUseCase>()));



// --- Mood Feature ---

  // 1. Data Source
  getIt.registerLazySingleton<MoodRemoteDataSource>(
        () => MoodRemoteDataSourceImpl(apiManager: getIt()),
  );

  // 2. Repository
  getIt.registerLazySingleton<MoodRepository>(
        () => MoodRepositoryImpl(moodRemoteDataSource: getIt()),
  );

  // 3. Use Case
  getIt.registerLazySingleton<MoodUseCase>(
        () => MoodUseCase(moodRepository: getIt()),
  );

  // 4. Cubit
  getIt.registerFactory<MoodCubit>(
        () => MoodCubit(moodUseCase: getIt()),
  );
}


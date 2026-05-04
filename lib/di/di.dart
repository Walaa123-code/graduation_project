import 'package:get_it/get_it.dart';

import '../core/api/api_manager.dart';
import '../features/home_tab/data/data_sources/remote_data_source_impl/mood_remote_data_source_impl.dart';
import '../features/home_tab/data/repositories/mood_repository_impl.dart';
import '../features/home_tab/domain/repositories/data_source/remote_data_source/mood_remote_data_source.dart';
import '../features/home_tab/domain/repositories/repositories/mood_repository.dart';
import '../features/home_tab/domain/use_cases/MoodUseCase.dart';
import '../features/home_tab/ui/manager/mood_cubit.dart';
import '../features/my_space/journals/data/data_sources/remote_data_source_impl/journal_data_source_impl.dart';
import '../features/my_space/journals/data/repositories/journal_repository_impl.dart';
import '../features/my_space/journals/domain/repositories/data_source/remote_data_source/journal_data_source.dart';
import '../features/my_space/journals/domain/repositories/repositories/journal_repository.dart';
import '../features/my_space/journals/domain/use_cases/journal_use_case.dart';
import '../features/my_space/journals/ui/manager/create_journal_cubit.dart';
import '../features/my_space/journals/ui/manager/delete_journal_cubit.dart';
import '../features/my_space/journals/ui/manager/journal_cubit.dart';
import '../features/my_space/journals/ui/manager/journal_details_cubit.dart';
import '../features/profile_user/data/data_source/remote_data_source_impl/profile_remote_data_source_impl.dart';
import '../features/profile_user/data/repositories/profile_repository_impl.dart';
import '../features/profile_user/domain/repositories/data_source/remote_data_source/profile_remote_data_source.dart';
import '../features/profile_user/domain/repositories/repositories/profile_repository.dart';
import '../features/profile_user/domain/use_cases/profile_use_case.dart';
import '../features/profile_user/ui/manager/profile_cubit.dart';

final getIt = GetIt.instance;

Future<void> initAppModule() async {
  // --- Core ---
  // تسجيل الـ ApiManager كـ Singleton لأنه يُستخدم في كل التطبيق
  getIt.registerLazySingleton<ApiManager>(() => ApiManager());

  // --- Profile Feature ---
  getIt.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
        profileRemoteDataSource: getIt<ProfileRemoteDataSource>()),
  );
  getIt.registerLazySingleton<ProfileUseCase>(
    () => ProfileUseCase(profileRepository: getIt<ProfileRepository>()),
  );
  getIt.registerFactory<ProfileCubit>(
    () => ProfileCubit(profileUseCase: getIt<ProfileUseCase>()),
  );

  // --- Mood Feature ---
  getIt.registerLazySingleton<MoodRemoteDataSource>(
    () => MoodRemoteDataSourceImpl(apiManager: getIt<ApiManager>()),
  );
  getIt.registerLazySingleton<MoodRepository>(
    () =>
        MoodRepositoryImpl(moodRemoteDataSource: getIt<MoodRemoteDataSource>()),
  );
  getIt.registerLazySingleton<MoodUseCase>(
    () => MoodUseCase(moodRepository: getIt<MoodRepository>()),
  );
  getIt.registerFactory<MoodCubit>(
    () => MoodCubit(moodUseCase: getIt<MoodUseCase>()),
  );
  // --- Journals Feature ---
  // 1. Data Source
  getIt.registerLazySingleton<JournalDataSource>(
    () => JournalDataSourceImpl(apiManager: getIt<ApiManager>()),
  );

  // 2. Repository
  getIt.registerLazySingleton<JournalRepository>(
    () => JournalRepositoryImpl(journalDataSource: getIt<JournalDataSource>()),
  );

  // 3. Use Case
  getIt.registerLazySingleton<JournalUseCase>(
    () => JournalUseCase(journalRepository: getIt<JournalRepository>()),
  );

  // 4. Cubit
  // استخدمنا registerFactory لضمان الحصول على نسخة جديدة عند كل فتح للـ Tab
  getIt.registerFactory<JournalCubit>(
    () => JournalCubit(getIt<JournalUseCase>()),
  );
  // get by id
  getIt.registerFactory<JournalDetailsCubit>(
    () => JournalDetailsCubit(getIt<JournalUseCase>()),
  );

  // create journal

// Cubit
  getIt.registerFactory<CreateJournalCubit>(
    () => CreateJournalCubit(getIt()),
  );
  // --- Delete Journal ---
  getIt.registerFactory<DeleteJournalCubit>(
    () => DeleteJournalCubit(getIt<JournalUseCase>()),
  );
}

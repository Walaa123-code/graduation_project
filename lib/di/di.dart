import 'package:get_it/get_it.dart';
import '../core/api/api_manager.dart';

// Mood
import '../features/auth/login/ui/manager/cubit/login_cubit.dart';
import '../features/auth/register/ui/manager/cubit/register_cubit.dart';
import '../features/home_tab/data/data_sources/remote_data_source_impl/mood_remote_data_source_impl.dart';

// Login
import '../features/auth/login/data/data_sources/remote/login_remote_data_source.dart';
import '../features/auth/login/data/data_sources/remote/login_remote_data_source_impl.dart';
import '../features/auth/login/data/repositories/login_repository_impl.dart';
import '../features/auth/login/domain/repositories/login_repository.dart';
import '../features/auth/login/domain/use_cases/login_use_case.dart';

// Register
import '../features/auth/register/data/data_sources/remote/register_remote_data_source.dart';
import '../features/auth/register/data/data_sources/remote/register_remote_data_source_impl.dart';
import '../features/auth/register/data/repositories/register_repository_impl.dart';
import '../features/auth/register/domain/repositories/register_repository.dart';
import '../features/auth/register/domain/use_cases/register_use_case.dart';

// Appointments
import '../features/appointments/data/data_sources/booking_data_source_impl.dart';
import '../features/appointments/data/repositories/booking_repository_impl.dart';
import '../features/appointments/domain/repositories/data_source/remote_data_source/booking_data_source.dart';
import '../features/appointments/domain/repositories/repositories/booking_repository.dart';
import '../features/appointments/domain/use_cases/booking_use_case.dart';
import '../features/appointments/ui/manager/booking_cubit.dart';

// ChatBot
import '../features/chatbot/data/data_sources/chatbot_data_source_impl.dart';
import '../features/chatbot/data/repositories/chatbot_repository_impl.dart';
import '../features/chatbot/domain/repositories/chatbot_repository.dart';
import '../features/chatbot/domain/repositories/data_source/chatbot_data_source.dart';
import '../features/chatbot/domain/use_cases/chatbot_use_case.dart';
import '../features/chatbot/ui/manager/chatbot_cubit.dart';import '../features/home_tab/data/repositories/mood_repository_impl.dart';
import '../features/home_tab/domain/repositories/data_source/remote_data_source/mood_remote_data_source.dart';
import '../features/home_tab/domain/repositories/repositories/mood_repository.dart';
import '../features/home_tab/domain/use_cases/MoodUseCase.dart';
import '../features/home_tab/ui/manager/mood_cubit.dart';

// Library
import '../features/libiraries/data/data_sources/library_data_source_impl.dart';
import '../features/libiraries/data/repositories/library_repository_impl.dart';
import '../features/libiraries/domain/repositories/data_source/remote_data_source/library_data_source.dart';
import '../features/libiraries/domain/repositories/repository/library_rebository.dart';
import '../features/libiraries/domain/use_cases/library_use_case.dart';
import '../features/libiraries/ui/manager/library_cubit.dart';

// Journals
import '../features/my_space/journals/data/data_sources/remote_data_source_impl/journal_data_source_impl.dart';
import '../features/my_space/journals/data/repositories/journal_repository_impl.dart';
import '../features/my_space/journals/domain/repositories/data_source/remote_data_source/journal_data_source.dart';
import '../features/my_space/journals/domain/repositories/repositories/journal_repository.dart';
import '../features/my_space/journals/domain/use_cases/journal_use_case.dart';
import '../features/my_space/journals/ui/manager/create_journal_cubit.dart';
import '../features/my_space/journals/ui/manager/delete_journal_cubit.dart';
import '../features/my_space/journals/ui/manager/journal_cubit.dart';
import '../features/my_space/journals/ui/manager/journal_details_cubit.dart';
import '../features/my_space/journals/ui/manager/update_journal_cubit.dart';

// Memories
import '../features/my_space/memories/data/data_sources/remote_data_source_impl/memory_data_source_impl.dart';
import '../features/my_space/memories/data/repositories/Memory_repository_impl.dart';
import '../features/my_space/memories/domain/repositories/data_source/remote_data_source/memory_data_source.dart';
import '../features/my_space/memories/domain/repositories/repositories/memory_repository.dart';
import '../features/my_space/memories/domain/use_cases/memory_use_case.dart';
import '../features/my_space/memories/ui/manager/create_memory_cubit.dart';
import '../features/my_space/memories/ui/manager/delete_memory_cubit.dart';
import '../features/my_space/memories/ui/manager/memory_cubit.dart';

// Profile
import '../features/profile_user/data/data_source/remote_data_source_impl/profile_remote_data_source_impl.dart';
import '../features/profile_user/data/repositories/profile_repository_impl.dart';
import '../features/profile_user/domain/repositories/data_source/remote_data_source/profile_remote_data_source.dart';
import '../features/profile_user/domain/repositories/repositories/profile_repository.dart';
import '../features/profile_user/domain/use_cases/profile_use_case.dart';
import '../features/profile_user/ui/manager/profile_cubit.dart';

final getIt = GetIt.instance;

Future<void> initAppModule() async {
  // --- Core ---
  getIt.registerLazySingleton<ApiManager>(() => ApiManager());

  // --- Login ---
  getIt.registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSourceImpl(apiManager: getIt<ApiManager>()));
  getIt.registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImpl(loginRemoteDataSource: getIt<LoginRemoteDataSource>()));
  getIt.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(loginRepository: getIt<LoginRepository>()));
  getIt.registerFactory<LoginCubit>(
      () => LoginCubit(loginUseCase: getIt<LoginUseCase>()));

  // --- Register ---
  getIt.registerLazySingleton<RegisterRemoteDataSource>(
      () => RegisterRemoteDataSourceImpl(apiManager: getIt<ApiManager>()));
  getIt.registerLazySingleton<RegisterRepository>(
      () => RegisterRepositoryImpl(registerRemoteDataSource: getIt<RegisterRemoteDataSource>()));
  getIt.registerLazySingleton<RegisterUseCase>(
      () => RegisterUseCase(registerRepository: getIt<RegisterRepository>()));
  getIt.registerFactory<RegisterCubit>(
      () => RegisterCubit(registerUseCase: getIt<RegisterUseCase>()));

  // --- Profile ---
  getIt.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl());
  getIt.registerLazySingleton<ProfileRepository>(() =>
      ProfileRepositoryImpl(
          profileRemoteDataSource: getIt<ProfileRemoteDataSource>()));
  getIt.registerLazySingleton<ProfileUseCase>(
      () => ProfileUseCase(profileRepository: getIt<ProfileRepository>()));
  getIt.registerFactory<ProfileCubit>(
      () => ProfileCubit(profileUseCase: getIt<ProfileUseCase>()));

  // --- Mood ---
  getIt.registerLazySingleton<MoodRemoteDataSource>(
      () => MoodRemoteDataSourceImpl(apiManager: getIt<ApiManager>()));
  getIt.registerLazySingleton<MoodRepository>(() =>
      MoodRepositoryImpl(
          moodRemoteDataSource: getIt<MoodRemoteDataSource>()));
  getIt.registerLazySingleton<MoodUseCase>(
      () => MoodUseCase(moodRepository: getIt<MoodRepository>()));
  // LazySingleton عشان نفس الـ instance يتشارك مع HomeTab
  getIt.registerLazySingleton<MoodCubit>(
      () => MoodCubit(moodUseCase: getIt<MoodUseCase>()));

  // --- Library ---
  getIt.registerLazySingleton<LibraryDateSource>(
      () => LibraryDataSourceImpl(apiManager: getIt<ApiManager>()));
  getIt.registerLazySingleton<LibraryRepository>(() =>
      LibraryRepositoryImpl(
          libraryDateSource: getIt<LibraryDateSource>()));
  getIt.registerLazySingleton<LibraryUseCase>(
      () => LibraryUseCase(libraryRepository: getIt<LibraryRepository>()));
  // LazySingleton عشان نفس الـ instance يتشارك بين HomeTab و LibraryTab
  getIt.registerLazySingleton<LibraryCubit>(
      () => LibraryCubit(libraryUseCase: getIt<LibraryUseCase>()));

  // --- Journals ---
  getIt.registerLazySingleton<JournalDataSource>(
      () => JournalDataSourceImpl(apiManager: getIt<ApiManager>()));
  getIt.registerLazySingleton<JournalRepository>(() =>
      JournalRepositoryImpl(
          journalDataSource: getIt<JournalDataSource>()));
  getIt.registerLazySingleton<JournalUseCase>(
      () => JournalUseCase(journalRepository: getIt<JournalRepository>()));
  getIt.registerFactory<JournalCubit>(
      () => JournalCubit(getIt<JournalUseCase>()));
  getIt.registerFactory<JournalDetailsCubit>(
      () => JournalDetailsCubit(getIt<JournalUseCase>()));
  getIt.registerFactory<CreateJournalCubit>(
      () => CreateJournalCubit(getIt<JournalUseCase>()));
  getIt.registerFactory<DeleteJournalCubit>(
      () => DeleteJournalCubit(getIt<JournalUseCase>()));
  getIt.registerFactory<UpdateJournalCubit>(
      () => UpdateJournalCubit(getIt<JournalUseCase>()));

  // --- Appointments ---
  getIt.registerLazySingleton<BookingDataSource>(
      () => BookingDataSourceImpl(apiManager: getIt<ApiManager>()));
  getIt.registerLazySingleton<BookingRepository>(
      () => BookingRepositoryImpl(bookingDataSource: getIt<BookingDataSource>()));
  getIt.registerLazySingleton<BookingUseCase>(
      () => BookingUseCase(bookingRepository: getIt<BookingRepository>()));
  getIt.registerFactory<BookingCubit>(
      () => BookingCubit(bookingUseCase: getIt<BookingUseCase>()));

  // --- ChatBot ---
  getIt.registerLazySingleton<ChatBotDataSource>(
      () => ChatBotDataSourceImpl(apiManager: getIt<ApiManager>()));
  getIt.registerLazySingleton<ChatBotRepository>(
      () => ChatBotRepositoryImpl(chatBotDataSource: getIt<ChatBotDataSource>()));
  getIt.registerLazySingleton<ChatBotUseCase>(
      () => ChatBotUseCase(chatBotRepository: getIt<ChatBotRepository>()));
  getIt.registerFactory<ChatBotCubit>(
      () => ChatBotCubit(chatBotUseCase: getIt<ChatBotUseCase>()));

  // --- Memories ---
  getIt.registerLazySingleton<MemoryDataSource>(      () => MemoryDataSourceImpl(apiManager: getIt<ApiManager>()));
  getIt.registerLazySingleton<MemoryRepository>(() =>
      MemoryRepositoryImpl(memoryDataSource: getIt<MemoryDataSource>()));
  getIt.registerLazySingleton<MemoryUseCase>(
      () => MemoryUseCase(memoryRepository: getIt<MemoryRepository>()));
  getIt.registerFactory<MemoryCubit>(
      () => MemoryCubit(getIt<MemoryUseCase>()));
  getIt.registerFactory<CreateMemoryCubit>(
      () => CreateMemoryCubit(getIt<MemoryUseCase>()));
  getIt.registerFactory<DeleteMemoryCubit>(
      () => DeleteMemoryCubit(getIt<MemoryUseCase>()));
}

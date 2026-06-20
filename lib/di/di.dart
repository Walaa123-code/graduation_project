import 'package:get_it/get_it.dart';

// ── Existing imports (unchanged) ─────────────────────────────────
import 'package:mindecho/features/user/profile_user/data/repositories/profile_repository_impl.dart';
import 'package:mindecho/features/user/profile_user/domain/repositories/data_source/remote_data_source/profile_remote_data_source.dart';
import 'package:mindecho/features/user/profile_user/domain/repositories/repositories/profile_repository.dart';
import 'package:mindecho/features/user/profile_user/domain/use_cases/profile_use_case.dart';
import 'package:mindecho/core/api/api_manager.dart';
import '../features/user/home_tab/data/data_sources/remote_data_source_impl/mood_remote_data_source_impl.dart';
import '../features/user/home_tab/data/repositories/mood_repository_impl.dart';
import '../features/user/home_tab/domain/repositories/data_source/remote_data_source/mood_remote_data_source.dart';
import '../features/user/home_tab/domain/repositories/repositories/mood_repository.dart';
import '../features/user/home_tab/domain/use_cases/MoodUseCase.dart';
import '../features/user/home_tab/ui/manager/mood_cubit.dart';
import '../features/user/profile_user/data/data_source/remote_data_source_impl/profile_remote_data_source_impl.dart';
import '../features/user/profile_user/ui/manager/profile_cubit.dart';

// ── Library imports ───────────────────────────────────────────────
import '../features/user/libiraries/data/data_sources/library_data_source_impl.dart';
import '../features/user/libiraries/data/repositories/library_repository_impl.dart';
import '../features/user/libiraries/domain/repositories/data_source/remote_data_source/library_data_source.dart';
import '../features/user/libiraries/domain/repositories/repository/library_rebository.dart';
import '../features/user/libiraries/domain/use_cases/library_use_case.dart';
import '../features/user/libiraries/ui/manager/library_cubit.dart';

// ── Register (auth) imports ───────────────────────────────────────
import '../features/auth/register/data/data_sources/remote/register_remote_data_source.dart';
import '../features/auth/register/data/data_sources/remote/register_remote_data_source_impl.dart';
import '../features/auth/register/data/repositories/register_repository_impl.dart';
import '../features/auth/register/domain/repositories/register_repository.dart';
import '../features/auth/register/domain/use_cases/register_use_case.dart';
import '../features/auth/register/ui/manager/cubit/register_cubit.dart';

// ── Journal (my_space) imports ────────────────────────────────────
import '../features/user/my_space/ui/widgets/journals/data/data_sources/remote_data_source_impl/journal_data_source_impl.dart';
import '../features/user/my_space/ui/widgets/journals/data/repositories/journal_repository_impl.dart';
import '../features/user/my_space/ui/widgets/journals/domain/repositories/data_source/remote_data_source/journal_data_source.dart';
import '../features/user/my_space/ui/widgets/journals/domain/repositories/repositories/journal_repository.dart';
import '../features/user/my_space/ui/widgets/journals/domain/use_cases/journal_use_case.dart';
import '../features/user/my_space/ui/widgets/journals/ui/manager/journal_cubit.dart';
import '../features/user/my_space/ui/widgets/journals/ui/manager/create_journal_cubit.dart';
import '../features/user/my_space/ui/widgets/journals/ui/manager/delete_journal_cubit.dart';
import '../features/user/my_space/ui/widgets/journals/ui/manager/journal_details_cubit.dart';
import '../features/user/my_space/ui/widgets/journals/ui/manager/update_journal_cubit.dart';

// ── Memory (my_space) imports ─────────────────────────────────────
import '../features/user/my_space/ui/widgets/memories/data/data_sources/remote_data_source_impl/memory_data_source_impl.dart';
import '../features/user/my_space/ui/widgets/memories/data/repositories/memory_repository_impl.dart';
import '../features/user/my_space/ui/widgets/memories/domain/repositories/data_source/remote_data_source/memory_data_source.dart';
import '../features/user/my_space/ui/widgets/memories/domain/repositories/repositories/memory_repository.dart' as memory_repo;
import '../features/user/my_space/ui/widgets/memories/domain/use_cases/memory_use_case.dart';
import '../features/user/my_space/ui/widgets/memories/ui/manager/memory_cubit.dart';
import '../features/user/my_space/ui/widgets/memories/ui/manager/create_memory_cubit.dart';
import '../features/user/my_space/ui/widgets/memories/ui/manager/delete_memory_cubit.dart';

// ── ChatBot imports ───────────────────────────────────────────────
import '../features/user/libiraries/ui/widgets/chatbot/data/data_sources/chatbot_data_source_impl.dart';
import '../features/user/libiraries/ui/widgets/chatbot/data/repositories/chatbot_repository_impl.dart';
import '../features/user/libiraries/ui/widgets/chatbot/domain/repositories/chatbot_repository.dart';
import '../features/user/libiraries/ui/widgets/chatbot/domain/repositories/data_source/chatbot_data_source.dart';
import '../features/user/libiraries/ui/widgets/chatbot/domain/use_cases/chatbot_use_case.dart';
import '../features/user/libiraries/ui/widgets/chatbot/ui/manager/chatbot_cubit.dart';

// ── New imports ───────────────────────────────────────────────────
import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/auth/domain/repositories/auth_repository.dart';
import '../features/auth/domain/use_cases/login_doctor_use_case.dart';
import '../features/auth/domain/use_cases/login_user_use_case.dart';
import '../features/auth/domain/use_cases/register_doctor_use_case.dart';
import '../features/auth/domain/use_cases/register_user_use_case.dart';
import '../features/auth/ui/manager/auth_cubit.dart';
import '../features/user/appointments/data/repositories/booking_repository_impl.dart';
import '../features/user/appointments/domain/repositories/booking_repository.dart';
import '../features/user/appointments/domain/use_cases/booking_use_cases.dart';
import '../features/user/appointments/ui/manager/booking_cubit.dart';
import '../features/Doctor/data/data_sources/doctor_remote_data_source_impl.dart';
import '../features/Doctor/domain/repositories/data_source/remote_data_source/doctor_remote_data_source.dart';
import '../features/Doctor/data/repositories/doctor_repository_impl.dart';
import '../features/Doctor/domain/repositories/repository/doctor_repository.dart';
import '../features/Doctor/domain/use_cases/doctor_use_cases.dart';
import 'package:mindecho/features/Doctor/ui/manager/doctor_cubit.dart';
import '../features/Doctor/data/data_sources/schedule_remote_data_source_impl.dart';
import '../features/Doctor/domain/repositories/data_source/remote_data_source/schedule_remote_data_source.dart';
import '../features/Doctor/data/repositories/schedule_repository_impl.dart';
import '../features/Doctor/domain/repositories/repository/schedule_repository.dart';
import '../features/Doctor/domain/use_cases/add_schedule_use_case.dart';
import 'package:mindecho/features/Doctor/ui/manager/schedule_cubit.dart';

// ── Chat (SignalR) imports ─────────────────────────────────────────
import '../features/chat/data/data_sources/chat_remote_data_source.dart';
import '../features/chat/data/repositories/chat_repository_impl.dart';
import '../features/chat/data/services/chat_signalr_service.dart';
import '../features/chat/domain/repositories/chat_repository.dart';
import '../features/chat/domain/use_cases/chat_use_cases.dart';
import 'package:mindecho/features/chat/ui/manager/chat_cubit.dart';

// ── Notification (SignalR) imports ────────────────────────────────
import '../features/user/profile_user/ui/manager/notification_cubit.dart';
import '../features/user/libiraries/ui/widgets/chatbot/data/data_sources/chatbot_data_source_impl.dart';
import '../features/user/libiraries/ui/widgets/chatbot/data/repositories/chatbot_repository_impl.dart';
import '../features/user/libiraries/ui/widgets/chatbot/domain/repositories/chatbot_repository.dart';
import '../features/user/libiraries/ui/widgets/chatbot/domain/repositories/data_source/chatbot_data_source.dart';
import '../features/user/libiraries/ui/widgets/chatbot/domain/use_cases/chatbot_use_case.dart';
import '../features/user/libiraries/ui/widgets/chatbot/ui/manager/chatbot_cubit.dart';
import '../features/user/my_space/ui/widgets/journals/ui/manager/update_journal_cubit.dart';
import '../features/user/profile_user/ui/manager/notification_cubit.dart';

final getIt = GetIt.instance;

Future<void> initAppModule() async {
  // ── Core: ApiManager (singleton) ──────────────────────────────
  getIt.registerLazySingleton<ApiManager>(() => ApiManager());

  // ── Profile (existing – unchanged) ────────────────────────────
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

  // ── Mood (existing – unchanged) ────────────────────────────────
  getIt.registerLazySingleton<MoodRemoteDataSource>(
    () => MoodRemoteDataSourceImpl(apiManager: getIt()),
  );
  getIt.registerLazySingleton<MoodRepository>(
    () => MoodRepositoryImpl(moodRemoteDataSource: getIt()),
  );
  getIt.registerLazySingleton<MoodUseCase>(
    () => MoodUseCase(moodRepository: getIt()),
  );
  getIt.registerFactory<MoodCubit>(
    () => MoodCubit(moodUseCase: getIt()),
  );

  // ── Library ────────────────────────────────────────────────────
  getIt.registerLazySingleton<LibraryDateSource>(
    () => LibraryDataSourceImpl(apiManager: getIt<ApiManager>()),
  );
  getIt.registerLazySingleton<LibraryRepository>(
    () => LibraryRepositoryImpl(libraryDateSource: getIt<LibraryDateSource>()),
  );
  getIt.registerLazySingleton<LibraryUseCase>(
    () => LibraryUseCase(libraryRepository: getIt<LibraryRepository>()),
  );
  getIt.registerFactory<LibraryCubit>(
    () => LibraryCubit(libraryUseCase: getIt<LibraryUseCase>()),
  );

  // ── Auth (new) ─────────────────────────────────────────────────
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(apiManager: getIt<ApiManager>()),
  );
  getIt.registerLazySingleton<RegisterUserUseCase>(
    () => RegisterUserUseCase(authRepository: getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<LoginUserUseCase>(
    () => LoginUserUseCase(authRepository: getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<RegisterDoctorUseCase>(
    () => RegisterDoctorUseCase(authRepository: getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<LoginDoctorUseCase>(
    () => LoginDoctorUseCase(authRepository: getIt<AuthRepository>()),
  );
  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(
      registerUserUseCase: getIt<RegisterUserUseCase>(),
      loginUserUseCase: getIt<LoginUserUseCase>(),
      registerDoctorUseCase: getIt<RegisterDoctorUseCase>(),
      loginDoctorUseCase: getIt<LoginDoctorUseCase>(),
    ),
  );

  // ── Booking (new) ──────────────────────────────────────────────
  getIt.registerLazySingleton<BookingRepository>(
    () => BookingRepositoryImpl(apiManager: getIt<ApiManager>()),
  );
  getIt.registerLazySingleton<CreateBookingUseCase>(
    () => CreateBookingUseCase(bookingRepository: getIt<BookingRepository>()),
  );
  getIt.registerLazySingleton<GetAllBookingsUseCase>(
    () => GetAllBookingsUseCase(
        bookingRepository: getIt<BookingRepository>()),
  );
  getIt.registerLazySingleton<ChangeBookingStatusUseCase>(
    () => ChangeBookingStatusUseCase(
        bookingRepository: getIt<BookingRepository>()),
  );
  getIt.registerFactory<BookingCubit>(
    () => BookingCubit(
      createBookingUseCase: getIt<CreateBookingUseCase>(),
      getAllBookingsUseCase: getIt<GetAllBookingsUseCase>(),
      changeBookingStatusUseCase: getIt<ChangeBookingStatusUseCase>(),
    ),
  );

  // ── Doctor (new) ────────────────────────────────────────────────
  getIt.registerLazySingleton<DoctorRemoteDataSource>(
    () => DoctorRemoteDataSourceImpl(apiManager: getIt<ApiManager>()),
  );
  getIt.registerLazySingleton<DoctorRepository>(
    () => DoctorRepositoryImpl(remoteDataSource: getIt<DoctorRemoteDataSource>()),
  );
  getIt.registerLazySingleton<GetDoctorProfileUseCase>(
    () => GetDoctorProfileUseCase(doctorRepository: getIt<DoctorRepository>()),
  );
  getIt.registerLazySingleton<UpdateDoctorProfileUseCase>(
    () => UpdateDoctorProfileUseCase(doctorRepository: getIt<DoctorRepository>()),
  );
  getIt.registerLazySingleton<GetAllDoctorsUseCase>(
    () => GetAllDoctorsUseCase(doctorRepository: getIt<DoctorRepository>()),
  );
  getIt.registerLazySingleton<GetDoctorPatientsUseCase>(
    () => GetDoctorPatientsUseCase(doctorRepository: getIt<DoctorRepository>()),
  );
  getIt.registerFactory<DoctorCubit>(
    () => DoctorCubit(
      getDoctorProfileUseCase: getIt<GetDoctorProfileUseCase>(),
      updateDoctorProfileUseCase: getIt<UpdateDoctorProfileUseCase>(),
      getAllDoctorsUseCase: getIt<GetAllDoctorsUseCase>(),
      getDoctorPatientsUseCase: getIt<GetDoctorPatientsUseCase>(),
    ),
  );

  // ── Doctor Schedule (new) ───────────────────────────────────────
  getIt.registerLazySingleton<ScheduleRemoteDataSource>(
    () => ScheduleRemoteDataSourceImpl(apiManager: getIt<ApiManager>()),
  );
  getIt.registerLazySingleton<ScheduleRepository>(
    () => ScheduleRepositoryImpl(remoteDataSource: getIt<ScheduleRemoteDataSource>()),
  );
  getIt.registerLazySingleton<AddScheduleUseCase>(
    () => AddScheduleUseCase(scheduleRepository: getIt<ScheduleRepository>()),
  );
  getIt.registerLazySingleton<GetSchedulesUseCase>(
    () => GetSchedulesUseCase(scheduleRepository: getIt<ScheduleRepository>()),
  );
  getIt.registerFactory<ScheduleCubit>(
    () => ScheduleCubit(
      addScheduleUseCase: getIt<AddScheduleUseCase>(),
      getSchedulesUseCase: getIt<GetSchedulesUseCase>(),
    ),
  );

  // ── Journal (my_space) ─────────────────────────────────────────
  getIt.registerLazySingleton<JournalDataSource>(
    () => JournalDataSourceImpl(apiManager: getIt<ApiManager>()),
  );
  getIt.registerLazySingleton<JournalRepository>(
    () => JournalRepositoryImpl(journalDataSource: getIt<JournalDataSource>()),
  );
  getIt.registerLazySingleton<JournalUseCase>(
    () => JournalUseCase(journalRepository: getIt<JournalRepository>()),
  );
  getIt.registerFactory<JournalCubit>(
    () => JournalCubit(getIt<JournalUseCase>()),
  );

  // ── Memory (my_space) ───────────────────────────────────────────
  getIt.registerLazySingleton<MemoryDataSource>(
    () => MemoryDataSourceImpl(apiManager: getIt<ApiManager>()),
  );
  getIt.registerLazySingleton<memory_repo.MemoryRepository>(
    () => MemoryRepositoryImpl(memoryDataSource: getIt<MemoryDataSource>()),
  );
  getIt.registerLazySingleton<MemoryUseCase>(
    () => MemoryUseCase(memoryRepository: getIt<memory_repo.MemoryRepository>()),
  );
  getIt.registerFactory<MemoryCubit>(
    () => MemoryCubit(getIt<MemoryUseCase>()),
  );

  // ── Chat (SignalR) ──────────────────────────────────────────────
  // Singleton: one hub connection shared across the app lifecycle.
  getIt.registerLazySingleton<ChatSignalRService>(
    () => ChatSignalRService(),
  );
  getIt.registerLazySingleton<ChatRemoteDataSource>(
    () => ChatRemoteDataSourceImpl(service: getIt<ChatSignalRService>()),
  );
  getIt.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(remoteDataSource: getIt<ChatRemoteDataSource>()),
  );
  getIt.registerLazySingleton<ConnectChatUseCase>(
    () => ConnectChatUseCase(chatRepository: getIt<ChatRepository>()),
  );
  getIt.registerLazySingleton<SendMessageUseCase>(
    () => SendMessageUseCase(chatRepository: getIt<ChatRepository>()),
  );
  getIt.registerLazySingleton<MarkAsReadUseCase>(
    () => MarkAsReadUseCase(chatRepository: getIt<ChatRepository>()),
  );
  getIt.registerLazySingleton<DisconnectChatUseCase>(
    () => DisconnectChatUseCase(chatRepository: getIt<ChatRepository>()),
  );
  // Factory: new ChatCubit instance each time a chat screen is opened.
  getIt.registerFactory<ChatCubit>(
    () => ChatCubit(
      connectChatUseCase:    getIt<ConnectChatUseCase>(),
      sendMessageUseCase:    getIt<SendMessageUseCase>(),
      markAsReadUseCase:     getIt<MarkAsReadUseCase>(),
      disconnectChatUseCase: getIt<DisconnectChatUseCase>(),
      chatRepository:        getIt<ChatRepository>(),
    ),
  );

  // ── Journal extra cubits ────────────────────────────────────────
  getIt.registerFactory<CreateJournalCubit>(
    () => CreateJournalCubit(getIt<JournalUseCase>()),
  );
  getIt.registerFactory<DeleteJournalCubit>(
    () => DeleteJournalCubit(getIt<JournalUseCase>()),
  );
  getIt.registerFactory<UpdateJournalCubit>(
    () => UpdateJournalCubit(getIt<JournalUseCase>()),
  );
  getIt.registerFactory<JournalDetailsCubit>(
    () => JournalDetailsCubit(getIt<JournalUseCase>()),
  );

  // ── Memory extra cubits ─────────────────────────────────────────
  getIt.registerFactory<CreateMemoryCubit>(
    () => CreateMemoryCubit(getIt<MemoryUseCase>()),
  );
  getIt.registerFactory<DeleteMemoryCubit>(
    () => DeleteMemoryCubit(getIt<MemoryUseCase>()),
  );

  // ── Register cubit ──────────────────────────────────────────────
  getIt.registerLazySingleton<RegisterRemoteDataSource>(
    () => RegisterRemoteDataSourceImpl(apiManager: getIt<ApiManager>()),
  );
  getIt.registerLazySingleton<RegisterRepository>(
    () => RegisterRepositoryImpl(
        registerRemoteDataSource: getIt<RegisterRemoteDataSource>()),
  );
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(registerRepository: getIt<RegisterRepository>()),
  );
  getIt.registerFactory<RegisterCubit>(
    () => RegisterCubit(registerUseCase: getIt<RegisterUseCase>()),
  );

  // ── Notification (SignalR) ─────────────────────────────────────
  // Singleton so the connection stays alive for the whole session.
  getIt.registerLazySingleton<NotificationCubit>(
    () => NotificationCubit()..init(),
  );

  // ── ChatBot ─────────────────────────────────────────────────────
  getIt.registerLazySingleton<ChatBotDataSource>(
    () => ChatBotDataSourceImpl(apiManager: getIt<ApiManager>()),
  );
  getIt.registerLazySingleton<ChatBotRepository>(
    () => ChatBotRepositoryImpl(chatBotDataSource: getIt<ChatBotDataSource>()),
  );
  getIt.registerLazySingleton<ChatBotUseCase>(
    () => ChatBotUseCase(chatBotRepository: getIt<ChatBotRepository>()),
  );
  getIt.registerFactory<ChatBotCubit>(
    () => ChatBotCubit(chatBotUseCase: getIt<ChatBotUseCase>()),
  );
}

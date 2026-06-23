class EndPoints {
  // ── Existing ─────────────────────────────────────────────────────
  static const String getProfile     = '/api/Client/profile';

  // ── Mood ─────────────────────────────────────────────────────────
  static const String selectMood     = '/api/MoodEntry/create';
  static const String getAllMoods    = '/api/MoodEntry/getall';
  static const String getMoodById    = '/api/MoodEntry/get/';
  static const String updateMood     = '/api/MoodEntry/update/';
  static const String deleteMood     = '/api/MoodEntry/delete/';

  // ── Library ──────────────────────────────────────────────────────
  static const String getLibrary     = '/api/Library/Library';

  // ── Auth ─────────────────────────────────────────────────────────
  static const String registerUser   = '/api/Auth/register-user';
  static const String loginUser      = '/api/Auth/login-user';
  static const String registerDoctor = '/api/Auth/register-doctor';
  static const String loginDoctor    = '/api/Auth/login-doctor';

  // ── Booking ──────────────────────────────────────────────────────
  static const String createBooking       = '/api/Booking/create';
  static const String getAllBookings      = '/api/Booking/getAllBookings';
  static const String changeBookingStatus = '/api/Booking/change-status';

  // ── ChatBot ──────────────────────────────────────────────────────
  static const String chatBotSend         = '/api/ChatBot/send';
  static const String chatBotHistory      = '/api/ChatBot/history';

  // ── Client ───────────────────────────────────────────────────────
  static const String getClientProfile    = '/api/Client/profile';
  static const String updateClientProfile = '/api/Client';

  // ── Doctor ───────────────────────────────────────────────────────
  static const String getDoctorProfile    = '/api/Doctor/profile';
  static const String updateDoctorProfile = '/api/Doctor';
  static const String getAllDoctors       = '/api/Doctor/All';
  static const String getDoctorPatients   = '/api/Doctor/patients';

  // ── Doctor Schedule ──────────────────────────────────────────────
  static const String addDoctorSchedule      = '/api/DoctorSchedule/Add';
  static const String updateDoctorSchedule   = '/api/DoctorSchedule/update';
  static const String deleteDoctorSchedule   = '/api/DoctorSchedule/{id}';
  static const String getDoctorSchedules     = '/api/DoctorSchedule/doctorSchedules';
  static const String getDoctorScheduleSlots = '/api/DoctorSchedule/slots';

  // ── Journal ──────────────────────────────────────────────────────
  static const String createJournal = '/api/Journal';
  static const String updateJournal = '/api/Journal/update';
  static const String getJournalById = '/api/Journal/{id}';
  static const String getUserJournals = '/api/Journal/user';
  static const String getJournals      = '/api/Journal';
  static const String getJournal       = '/api/Journal';
  static const String deleteJournal    = '/api/Journal/{id}';

  // ── Memory ───────────────────────────────────────────────────────
  static const String createMemory = '/api/Memory/create';
  static const String updateMemory = '/api/Memory/update';
  static const String getMemoryById = '/api/Memory/{id}';
  static const String getUserMemories = '/api/Memory/user';
  static const String getMemories      = '/api/Memory';
  static const String getMemory        = '/api/Memory';
  static const String deleteMemory     = '/api/Memory/{id}';

  // ── Mood Entry ───────────────────────────────────────────────────
  static const String createMoodEntry = '/api/MoodEntry/create';
  static const String updateMoodEntry = '/api/MoodEntry/update';
  static const String deleteMoodEntry = '/api/MoodEntry/delete/{id}';
  static const String getMoodEntryById = '/api/MoodEntry/get/{id}';
  static const String getAllMoodEntries = '/api/MoodEntry/getall';

  // ── SignalR ───────────────────────────────────────────────────────
  static const String chatHub = '/hubs/chat';
}
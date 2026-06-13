class EndPoints {
  // ── Auth ─────────────────────────────────────────────────────────
  static const String registerUser   = '/api/Auth/register-user';
  static const String loginUser      = '/api/Auth/login-user';
  static const String registerDoctor = '/api/Auth/register-doctor';
  static const String loginDoctor    = '/api/Auth/login-doctor';

  // ── Booking ──────────────────────────────────────────────────────
  static const String createBooking       = '/api/Booking/create';
  static const String getAllBookings      = '/api/Booking/getAllBookings';
  static const String changeBookingStatus = '/api/Booking/changeStatus';

  // ── Doctor ───────────────────────────────────────────────────────
  static const String getDoctorProfile  = '/api/Doctor/profile';
  static const String updateDoctorProfile = '/api/Doctor';
  static const String getAllDoctors     = '/api/Doctor/All';
  static const String getDoctorPatients = '/api/Doctor/patients';

  // ── Doctor Schedule ──────────────────────────────────────────────
  static const String addDoctorSchedule = '/api/DoctorSchedule/Add';
  static const String updateDoctorSchedule = '/api/DoctorSchedule/update';
  static const String getDoctorScheduleById = '/api/DoctorSchedule/{id}';
  static const String getDoctorSchedules = '/api/DoctorSchedule/doctorSchedules';
  static const String getDoctorScheduleSlots = '/api/DoctorSchedule/slots';

  // ── Journal ──────────────────────────────────────────────────────
  static const String createJournal    = '/api/Journal';
  static const String getJournals      = '/api/Journal';
  static const String getJournal       = '/api/Journal';
  static const String getJournalById   = '/api/Journal/{id}';
  static const String updateJournal    = '/api/Journal';
  static const String deleteJournal    = '/api/Journal/{id}';

  // ── Memory ───────────────────────────────────────────────────────
  static const String getMemories      = '/api/Memory';
  static const String getMemory        = '/api/Memory';
  static const String getMemoryById    = '/api/Memory/{id}';
  static const String createMemory     = '/api/Memory';
  static const String updateMemory     = '/api/Memory';
  static const String deleteMemory     = '/api/Memory/{id}';

  // ── SignalR ───────────────────────────────────────────────────────
  /// Full URL: ApiConstants.baseUrl + EndPoints.chatHub
  /// → https://chef-reclining-deodorize.ngrok-free.dev/hubs/chat
  static const String chatHub = '/hubs/chat';
}
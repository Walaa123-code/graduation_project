class EndPoints {
  // ── Existing endpoints (do not remove) ──────────────────────────
  static const String getProfile = '/api/Client';
  static const String selectMood = '/api/MoodEntry/create';

  // ── Auth ─────────────────────────────────────────────────────────
  static const String registerUser   = '/api/Auth/register-user';
  static const String loginUser      = '/api/Auth/login-user';
  static const String registerDoctor = '/api/Auth/register-doctor';
  static const String loginDoctor    = '/api/Auth/login-doctor';

  // ── Booking ──────────────────────────────────────────────────────
  static const String createBooking       = '/api/Booking';
  static const String getAllBookings      = '/api/Booking/getAllBookings';
  static const String changeBookingStatus = '/api/Booking/change-status';

  // ── Doctor ───────────────────────────────────────────────────────
  static const String getDoctorProfile  = '/api/Doctor';
  static const String updateDoctorProfile = '/api/Doctor';
  static const String getAllDoctors     = '/api/Doctor/get-all-doctors';

  // ── Doctor Schedule ──────────────────────────────────────────────
  static const String addDoctorSchedule = '/api/DoctorSchedule/Add';

  // ── Journal ──────────────────────────────────────────────────────
  static const String createJournal = '/api/Journal';
  static const String getJournals   = '/api/Journal';

  // ── Memory ───────────────────────────────────────────────────────
  static const String createMemory = '/api/Memory/create';
  static const String getMemories  = '/api/Memory';
}
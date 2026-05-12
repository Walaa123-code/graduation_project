class EndPoints {
  static const String getProfile = "/api/Client";

  // Mood
  static const String selectMood = "/api/MoodEntry/create";
  static const String getAllMoods = "/api/MoodEntry/getall";
  static const String getMoodById = "/api/MoodEntry/get/";
  static const String updateMood = "/api/MoodEntry/update";
  static const String deleteMood = "/api/MoodEntry/delete/";

  // Journal
  static const String getJournal = "/api/Journal/user";
  static const String getJournalById = "/api/Journal/";
  static const String createJournal = "/api/Journal";
  static const String updateJournal = "/api/Journal/update";
  static const String deleteJournal = "/api/Journal/";

  // Memory
  static const String getMemory = "/api/Memory/user";
  static const String getMemoryById = "/api/Memory/";
  static const String createMemory = "/api/Memory/create";
  static const String updateMemory = "/api/Memory/update";
  static const String deleteMemory = "/api/Memory/";

  // Library
  static const String getLibrary = "/api/Library/Library";

  // Appointments
  static const String createBooking = "/api/Booking/create";
  static const String changeBookingStatus = "/api/Booking/change-status";
  static const String getAllBookings = "/api/Booking/getAllBookings";
}

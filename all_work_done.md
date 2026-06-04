# All Work Done: MINDECHO Project Handoff

This document summarizes all the recent development work, API integrations, bug fixes, and architectural choices made in the MINDECHO Flutter application. This is intended as a **handoff document** for any other developer or AI agent continuing work on this project.

## 🏗️ Architecture & State Management
- **Architecture**: Clean Architecture (Data -> Domain -> UI).
- **State Management**: `flutter_bloc` (Cubits). `DoctorState` was refactored into a single unified data class (`profile`, `patients`, `allDoctors`, `isLoading`, `error`) with a `copyWith` method to prevent different screens from clobbering each other's state data.
- **Dependency Injection**: `get_it` configured in `lib/di/di.dart`.
- **Networking**: `dio` wrapped in a custom `ApiManager` (`lib/core/api/api_manager.dart`).

## 🔌 API Integration details
- **Live Base URL**: Currently pointing to the ngrok server: `https://chef-reclining-deodorize.ngrok-free.dev`. This is configured in `lib/core/api/api_constants.dart`.
- **Endpoints Configured**: Endpoints are defined in `lib/core/api/end_points.dart`.
- **Error Handling**: `ApiManager` intercepts Dio exceptions. Detailed console logging was added to print the request URL, status code, and response body whenever a `400 Bad Request` or similar error occurs.

---

## ✅ Completed Features & Work

### 1. Authentication (Auth Layer)
- Built `AuthRepositoryImpl`, Use Cases (`RegisterDoctorUseCase`, `LoginDoctorUseCase`, etc.), and `AuthCubit`.
- **Registration Screens**: Created `DoctorRegisterScreen` and `UserRegisterScreen`.
- **Strict Backend Validations Fixed**: 
  - **Age**: The API strictly requires Age to be between **25 and 100**. Added front-end validation.
  - **Password**: The API strictly requires at least 1 uppercase letter, 1 special character (non-alphanumeric), and a minimum of 6 characters. Added front-end regex validation and error messages.
- **Role Toggle**: The `LoginScreen` has a toggle to switch between User and Doctor logins. Upon successful Doctor login, it routes to `/doctor/main`.

### 2. Doctor Dashboard & Main Screen
- Created `DoctorMainScreen` which uses an `IndexedStack` and a `BottomNavigationBar` to switch between:
  - Home (`DoctorHomeScreen`)
  - Patients (`PatientsScreen`)
  - Schedule (`AppointmentsScreen`)
  - Profile (`DoctorProfileScreen`)
- **Important**: `DoctorCubit` and `ScheduleCubit` are injected at the top level in `main.dart` using `MultiBlocProvider`. *(Note: If adding new providers here, a **Hot Restart** is required, not just a hot reload).*

### 3. Doctor Home Screen
- Displays doctor profile information dynamically (`DoctorProfileLoadedState`).
- Fetches real live API data on `initState` via:
  - `context.read<DoctorCubit>().getDoctorProfile()`
  - `context.read<ScheduleCubit>().getSchedules()`
- Includes a top header, stats cards (showing real schedule/patient counts), a dynamic list of upcoming schedules, and a quick actions grid.

### 4. Schedule / Appointments Management
- **Schedule Entity & Data**: Created `ScheduleEntity`, `ScheduleDM`, `ScheduleRepositoryImpl`, and `ScheduleCubit`.
- **Add Schedule (`POST /api/DoctorSchedule/Add`)**: Successfully integrated. Fixes were made to send data using `FormData.fromMap` as expected by the backend.
- **View Schedules (`GET /api/DoctorSchedule/doctorSchedules`)**: Fixed a 400 Bad Request `The DoctorId field is required.` by extracting the `DoctorId` from `DoctorCubit.state.profile.id` and passing it to the repository dynamically.
- **View Bookings (`GET /api/Booking/getAllBookings`)**: Removed the static dummy lists from `AppointmentsScreen`. Implemented `BookingCubit` and `GetAllBookingsUseCase` to fetch live data.
- **Dynamic Stats Headers**: The `AppointmentsHeader` was refactored to compute real 'Completed', 'Upcoming', and 'Today' slot statistics via `BlocBuilder<BookingCubit, BookingState>`.

### 5. Patients List
- Integrated `GET /api/Doctor/patients`.
- Created `DoctorListEntity`, Use Cases, and repository methods.
- The `PatientsScreen` now maps real patient data fetched from the API instead of dummy data.
- **Fixed Crash**: The API responds with a `400 Bad Request` and `success: false` (message: "No patients found for this doctor") instead of returning an empty array when the doctor has no patients. Added a custom `DioException` interceptor in `DoctorRepositoryImpl` to gracefully catch this exact message and return an empty `DoctorListEntity([])` instead of crashing the UI.

### 6. Doctor Profile
- Fetches profile from `GET /api/Doctor/profile`.
- Displays real user name, email, specialty, and bio.
- Implemented a working logout flow that clears dependencies and routes back to the splash/login screen.

---

## 🛠️ Next Steps / Areas to Expand

1. **User Flow**: The *Doctor* flow is mostly complete. The *User* (Patient) flow still needs to be expanded (e.g., mapping user home, exploring doctors, booking an appointment).
2. **Missing Endpoints Integration**: There are several new endpoints available on the ngrok server (e.g., ChatBot, Library, Memory, Journal) that are listed in `available_endpoints.md` but are not fully wired up to the UI yet.
3. **Image Uploads**: `updateDoctorProfile` expects a `ProfilePicture` as a multipart file. The UI for selecting and cropping an image needs to be fully wired up to this repository method.
4. **Forgot Password**: The UI has a "Forgot Password" button but it is not implemented.

## 🐛 Common Gotchas for Agents
- **Dependency Injection**: Always make sure newly created Repositories, Use Cases, and Cubits are registered in `lib/di/di.dart`, and provided in `lib/main.dart` inside the `MultiBlocProvider`. 
- **Type Mismatches**: When working with Flutter `BlocBuilder`, always explicitly declare the type (e.g., `final List<ScheduleEntity> schedules = (state as ScheduleListLoadedState).schedules;`) instead of relying on ternary operators that can fall back to `<dynamic>` or `<Object>`.
- **API Formatting**: The .NET backend uses PascalCase in many responses (e.g., `FullName`, `ProfilePicture`), but the Dart models might expect camelCase. Double-check `fromJson` methods if data parses incorrectly. The `DoctorProfileDM` has been updated to check for both `json['fullName'] ?? json['FullName']` to robustly handle this.
- **ngrok CORS Bypass**: Since the backend runs on a free ngrok instance, ngrok intercepts requests from the browser with a warning page. This breaks API calls in Flutter web (`XMLHttpRequest onError`). To fix this, an `'ngrok-skip-browser-warning': '69420'` header has been globally added to the `ApiManager`'s Dio `BaseOptions`.
- **Dart Import Case Sensitivity**: Windows is case-insensitive for file paths, but Dart treats URIs with different casing as entirely separate libraries. For example, `import '../features/doctor/...'` and `import '../features/Doctor/...'` will create duplicate types at runtime and cause mysterious `ProviderNotFoundException` errors. **Always** make sure the casing in your `import` statements exactly matches the physical folder casing (`Doctor`, `auth`, `profile_user`, etc.).
- **Backend HTTP 400 for Empty Data**: The .NET backend sometimes uses HTTP 400 Bad Request with a `success: false` flag and an error message when it really just means "No data found" (e.g., Doctor has zero patients). When integrating lists, explicitly catch `DioException` and look for the specific empty-state text in `e.response?.data['message']` to return an empty array instead of surfacing an error string to the user.

part of 'library_cubit.dart';

@immutable
sealed class LibraryState {}

final class LibraryInitialState extends LibraryState {}

final class LibraryLoadingState extends LibraryState {}

final class LibrarySuccessState extends LibraryState {
  final LibraryResponseEntity libraryResponseEntity;
  LibrarySuccessState({required this.libraryResponseEntity});
}

final class LibraryErrorState extends LibraryState {
  final Failures failures;
  LibraryErrorState({required this.failures});
}

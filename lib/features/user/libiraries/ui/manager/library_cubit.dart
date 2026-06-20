
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/core/errors/failures.dart';
import '../../domain/entities/LibraryResponseEntity.dart';
import '../../domain/use_cases/library_use_case.dart';

part 'library_state.dart';

class LibraryCubit extends Cubit<LibraryState> {
  final LibraryUseCase libraryUseCase;
  LibraryCubit({required this.libraryUseCase}) : super(LibraryInitialState());

  Future<void> getLibrary(int mood) async {
    emit(LibraryLoadingState());
    var either = await libraryUseCase.invoke(mood);
    either.fold(
      (error) => emit(LibraryErrorState(failures: error)),
      (response) =>
          emit(LibrarySuccessState(libraryResponseEntity: response)),
    );
  }
}

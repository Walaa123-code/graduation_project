import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/errors/failures.dart';
import 'package:graduation_project/features/profile_user/domain/entities/ProfileResponseEntity.dart';
import 'package:graduation_project/features/profile_user/domain/use_cases/profile_use_case.dart';
import 'package:injectable/injectable.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final ProfileUseCase profileUseCase;
  ProfileCubit({required this.profileUseCase}) : super(ProfileInitialState());
  Future<void> getProfile() async {
    emit(ProfileLoadingState());
    var either = await profileUseCase.invoke();
    either.fold((error) {
      emit(ProfileErrorState(failures: error));
    }, (response) {
      emit(ProfileSuccessState(profileResponseEntity: response));
    });
  }
}

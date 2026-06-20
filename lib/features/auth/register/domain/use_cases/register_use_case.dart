import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../entities/register_response_entity.dart';
import '../repositories/register_repository.dart';

class RegisterUseCase {
  final RegisterRepository registerRepository;

  RegisterUseCase({
    required this.registerRepository,
  });

  Future<Either<Failures, RegisterResponseEntity>> invoke(
    String name,
    String email,
    String password,
    int age,
    String gender,
  ) {
    return registerRepository.register(
      name,
      email,
      password,
      age,
      gender,
    );
  }
}

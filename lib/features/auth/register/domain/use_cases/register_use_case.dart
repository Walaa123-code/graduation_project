import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failures.dart';
import '../entities/register_response_entity.dart';
import '../repositories/register_repository.dart';

class RegisterUseCase {
  final RegisterRepository registerRepository;
  RegisterUseCase({required this.registerRepository});

  Future<Either<Failures, RegisterResponseEntity>> invoke(
          String name, String email, String password) =>
      registerRepository.register(name, email, password);
}

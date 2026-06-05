import 'package:dartz/dartz.dart';
import '../../../../../../core/errors/failures.dart';
import '../../../domain/entities/register_response_entity.dart';

abstract class RegisterRemoteDataSource {
  Future<Either<Failures, RegisterResponseEntity>> register(
      String name, String email, String password);
}

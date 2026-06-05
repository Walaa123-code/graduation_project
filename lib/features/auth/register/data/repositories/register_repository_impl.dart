import 'package:dartz/dartz.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/features/auth/register/domain/entities/register_response_entity.dart';
import 'package:mindecho/features/auth/register/domain/repositories/register_repository.dart';
import '../data_sources/remote/register_remote_data_source.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterRemoteDataSource registerRemoteDataSource;
  RegisterRepositoryImpl({required this.registerRemoteDataSource});

  @override
  Future<Either<Failures, RegisterResponseEntity>> register(
      String name, String email, String password) async {
    var either = await registerRemoteDataSource.register(name, email, password);
    return either.fold((e) => left(e), (r) => right(r));
  }
}

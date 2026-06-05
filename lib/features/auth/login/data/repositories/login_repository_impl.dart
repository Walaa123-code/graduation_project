import 'package:dartz/dartz.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/features/auth/login/domain/entities/login_response_entity.dart';
import 'package:mindecho/features/auth/login/domain/repositories/login_repository.dart';
import '../data_sources/remote/login_remote_data_source.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource loginRemoteDataSource;
  LoginRepositoryImpl({required this.loginRemoteDataSource});

  @override
  Future<Either<Failures, LoginResponseEntity>> login(
      String email, String password) async {
    var either = await loginRemoteDataSource.login(email, password);
    return either.fold((e) => left(e), (r) => right(r));
  }
}

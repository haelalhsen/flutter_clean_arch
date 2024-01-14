import 'package:dartz/dartz.dart';
import 'package:test_clean_arch/core/error/failures.dart';
import 'package:test_clean_arch/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:test_clean_arch/features/auth/data/models/user_model.dart';
import 'package:test_clean_arch/features/auth/domain/entities/user.dart';
import 'package:test_clean_arch/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, User>> loginUser(
      String username, String password) async {
    UserModel user = UserModel(username: username, password: password);
    try {
      await localDataSource.registerUser(user);
      return Right(user);
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

}

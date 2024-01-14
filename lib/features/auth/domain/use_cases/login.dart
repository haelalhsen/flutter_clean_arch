import 'package:dartz/dartz.dart';
import 'package:test_clean_arch/features/auth/domain/repositories/auth_repository.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, User>> call(String username, String password) async {
    return await repository.loginUser(username, password);
  }
}

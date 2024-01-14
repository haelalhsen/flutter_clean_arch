import 'package:dartz/dartz.dart';
import 'package:test_clean_arch/features/auth/domain/entities/user.dart';

import '../../../../core/error/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> loginUser(
      String username,
      String password,
      );
}
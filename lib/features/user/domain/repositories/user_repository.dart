import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> login(User params);
  Future<Either<Failure, String>> changePassword(
    String username,
    String oldPassword,
    String newPassword,
  );
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, User>> autoLogin();
}

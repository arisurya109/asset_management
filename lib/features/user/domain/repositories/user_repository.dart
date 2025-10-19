import '../../../../core/error/failure.dart';
import '../entities/user.dart';

import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> login(String username, String password);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, User>> autoLogin();
}

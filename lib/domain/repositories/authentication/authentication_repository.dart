import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/authentication/authentication.dart';
import '../../entities/user/user.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, User>> login(Authentication params);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, String>> changePassword(Authentication params);
  Future<Either<Failure, User>> autoLogin();
}

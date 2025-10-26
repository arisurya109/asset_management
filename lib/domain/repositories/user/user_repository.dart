import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../entities/user/user.dart';

abstract class UserRepository {
  Future<Either<Failure, List<User>>> findAllUser();
  Future<Either<Failure, User>> createUser(User params);
  Future<Either<Failure, User>> findUserById(int params);
  Future<Either<Failure, User>> updateUser(User params);
  Future<Either<Failure, String>> deleteUser(int params);
}

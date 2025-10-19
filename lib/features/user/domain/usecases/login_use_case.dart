import '../../../../core/error/failure.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

import 'package:dartz/dartz.dart';

class LoginUseCase {
  final UserRepository _repository;

  LoginUseCase(this._repository);

  Future<Either<Failure, User>> call(String username, String password) async {
    return _repository.login(username, password);
  }
}

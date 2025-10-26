import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../entities/authentication/authentication.dart';
import '../../entities/user/user.dart';
import '../../repositories/authentication/authentication_repository.dart';

class LoginUseCase {
  final AuthenticationRepository _repository;

  LoginUseCase(this._repository);

  Future<Either<Failure, User>> call(Authentication params) async {
    return _repository.login(params);
  }
}

import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../entities/user/user.dart';
import '../../repositories/authentication/authentication_repository.dart';

class AutoLoginUseCase {
  final AuthenticationRepository _repository;

  AutoLoginUseCase(this._repository);

  Future<Either<Failure, User>> call() async {
    return _repository.autoLogin();
  }
}

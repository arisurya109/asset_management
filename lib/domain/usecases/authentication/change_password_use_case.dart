import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../entities/authentication/authentication.dart';
import '../../repositories/authentication/authentication_repository.dart';

class ChangePasswordUseCase {
  final AuthenticationRepository _repository;

  ChangePasswordUseCase(this._repository);

  Future<Either<Failure, String>> call(Authentication params) async {
    return _repository.changePassword(params);
  }
}

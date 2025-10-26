import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../entities/user/user.dart';
import '../../repositories/user/user_repository.dart';

class UpdateUserUseCase {
  final UserRepository _repository;

  UpdateUserUseCase(this._repository);

  Future<Either<Failure, User>> call(User params) {
    return _repository.updateUser(params);
  }
}

import '../../../core/core.dart';
import '../../entities/user/user.dart';
import '../../repositories/user/user_repository.dart';

import 'package:dartz/dartz.dart';

class CreateUserUseCase {
  final UserRepository _repository;

  CreateUserUseCase(this._repository);

  Future<Either<Failure, User>> call(User params) async {
    return _repository.createUser(params);
  }
}

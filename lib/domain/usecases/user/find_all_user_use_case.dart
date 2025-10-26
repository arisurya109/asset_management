import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../entities/user/user.dart';
import '../../repositories/user/user_repository.dart';

class FindAllUserUseCase {
  final UserRepository _repository;

  FindAllUserUseCase(this._repository);

  Future<Either<Failure, List<User>>> call() async {
    return _repository.findAllUser();
  }
}

import '../../../../core/error/failure.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

import 'package:dartz/dartz.dart';

class AutoLoginUseCase {
  final UserRepository _repository;

  AutoLoginUseCase(this._repository);

  Future<Either<Failure, User>> call() async {
    return _repository.autoLogin();
  }
}

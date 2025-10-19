import '../../../../core/error/failure.dart';
import '../repositories/user_repository.dart';

import 'package:dartz/dartz.dart';

class LogoutUseCase {
  final UserRepository _repository;

  LogoutUseCase(this._repository);

  Future<Either<Failure, void>> call() async {
    return _repository.logout();
  }
}

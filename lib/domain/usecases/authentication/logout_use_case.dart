import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../repositories/authentication/authentication_repository.dart';

class LogoutUseCase {
  final AuthenticationRepository _repository;

  LogoutUseCase(this._repository);

  Future<Either<Failure, void>> call() async {
    return _repository.logout();
  }
}

import 'package:asset_management/core/core.dart';
import 'package:asset_management/features/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class LogoutUseCase {
  final UserRepository _repository;

  LogoutUseCase(this._repository);

  Future<Either<Failure, void>> call() async {
    return _repository.logout();
  }
}

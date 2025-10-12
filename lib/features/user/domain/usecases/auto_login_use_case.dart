import 'package:asset_management/core/core.dart';
import 'package:asset_management/features/user/domain/entities/user.dart';
import 'package:asset_management/features/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class AutoLoginUseCase {
  final UserRepository _repository;

  AutoLoginUseCase(this._repository);

  Future<Either<Failure, User>> call() async {
    return _repository.autoLogin();
  }
}

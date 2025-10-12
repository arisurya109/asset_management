import 'package:asset_management/core/core.dart';
import 'package:asset_management/features/user/domain/entities/user.dart';
import 'package:asset_management/features/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase {
  final UserRepository _repository;

  LoginUseCase(this._repository);

  Future<Either<Failure, User>> call(User params) async {
    return _repository.login(params);
  }
}

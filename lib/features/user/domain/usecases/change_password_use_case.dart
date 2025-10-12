import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/features/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class ChangePasswordUseCase {
  final UserRepository _repository;

  ChangePasswordUseCase(this._repository);

  Future<Either<Failure, String>> call(
    String username,
    String oldPassword,
    String newPassword,
  ) async {
    return _repository.changePassword(username, oldPassword, newPassword);
  }
}

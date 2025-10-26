import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/domain/repositories/user/user_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteUserUseCase {
  final UserRepository _repository;

  DeleteUserUseCase(this._repository);

  Future<Either<Failure, String>> call(int params) async {
    return _repository.deleteUser(params);
  }
}

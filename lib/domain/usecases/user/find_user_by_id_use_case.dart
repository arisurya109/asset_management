import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/user/user.dart';
import 'package:asset_management/domain/repositories/user/user_repository.dart';
import 'package:dartz/dartz.dart';

class FindUserByIdUseCase {
  final UserRepository _repository;

  FindUserByIdUseCase(this._repository);

  Future<Either<Failure, User>> call(int params) async {
    return _repository.findUserById(params);
  }
}

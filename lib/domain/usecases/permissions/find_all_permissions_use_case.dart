import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/permissions/permissions.dart';
import 'package:asset_management/domain/repositories/permissions/permissions_repository.dart';
import 'package:dartz/dartz.dart';

class FindAllPermissionsUseCase {
  final PermissionsRepository _repository;

  FindAllPermissionsUseCase(this._repository);

  Future<Either<Failure, List<Permissions>>> call() async {
    return _repository.findAllPermissions();
  }
}

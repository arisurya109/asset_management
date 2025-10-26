import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/permissions/permissions.dart';
import 'package:dartz/dartz.dart';

abstract class PermissionsRepository {
  Future<Either<Failure, List<Permissions>>> findAllPermissions();
}

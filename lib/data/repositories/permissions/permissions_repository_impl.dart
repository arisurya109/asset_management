import 'package:asset_management/core/core.dart';
import 'package:asset_management/data/source/permissions/permissions_remote_data_source.dart';
import 'package:asset_management/domain/entities/permissions/permissions.dart';
import 'package:asset_management/domain/repositories/permissions/permissions_repository.dart';
import 'package:dartz/dartz.dart';

class PermissionsRepositoryImpl implements PermissionsRepository {
  final PermissionsRemoteDataSource _source;

  PermissionsRepositoryImpl(this._source);

  @override
  Future<Either<Failure, List<Permissions>>> findAllPermissions() async {
    try {
      final response = await _source.findAllPermissions();
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }
}

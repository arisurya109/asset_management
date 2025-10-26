import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/master/location.dart';
import 'package:asset_management/domain/repositories/master/master_repository.dart';
import 'package:dartz/dartz.dart';

class CreateLocationUseCase {
  final MasterRepository _repository;

  CreateLocationUseCase(this._repository);

  Future<Either<Failure, Location>> call(Location params) async {
    return _repository.createLocation(params);
  }
}

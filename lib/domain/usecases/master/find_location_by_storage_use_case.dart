import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/master/location.dart';
import 'package:asset_management/domain/repositories/master/master_repository.dart';
import 'package:dartz/dartz.dart';

class FindLocationByStorageUseCase {
  final MasterRepository _repository;

  FindLocationByStorageUseCase(this._repository);

  Future<Either<Failure, List<Location>>> call(String params) async {
    return _repository.findLocationByStorage(params);
  }
}

import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/master/location.dart';
import 'package:asset_management/domain/repositories/master/master_repository.dart';
import 'package:dartz/dartz.dart';

class FindAllLocationUseCase {
  final MasterRepository _repository;

  FindAllLocationUseCase(this._repository);

  Future<Either<Failure, List<Location>>> call() async {
    return _repository.findAllLocation();
  }
}

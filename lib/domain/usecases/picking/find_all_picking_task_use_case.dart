import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/picking/picking.dart';
import 'package:asset_management/domain/repositories/picking/picking_repository.dart';
import 'package:dartz/dartz.dart';

class FindAllPickingTaskUseCase {
  final PickingRepository _repository;

  FindAllPickingTaskUseCase(this._repository);

  Future<Either<Failure, List<Picking>>> call() async {
    return _repository.findAllPickingTask();
  }
}

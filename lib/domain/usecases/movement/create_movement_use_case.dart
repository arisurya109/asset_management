import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/movement/movement.dart';
import 'package:asset_management/domain/repositories/movement/movement_repository.dart';
import 'package:dartz/dartz.dart';

class CreateMovementUseCase {
  final MovementRepository _repository;

  CreateMovementUseCase(this._repository);

  Future<Either<Failure, String>> call(Movement params) async {
    return _repository.createMovement(params);
  }
}

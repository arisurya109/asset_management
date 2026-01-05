import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/movement/movement.dart';
import 'package:dartz/dartz.dart';

abstract class MovementRepository {
  Future<Either<Failure, String>> createMovement(Movement params);
}

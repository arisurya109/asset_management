import 'package:asset_management/core/error/exception.dart';
import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/data/model/movement/movement_model.dart';
import 'package:asset_management/data/source/movement/movement_remote_data_source.dart';
import 'package:asset_management/domain/entities/movement/movement.dart';
import 'package:asset_management/domain/repositories/movement/movement_repository.dart';
import 'package:dartz/dartz.dart';

class MovementRepositoryImpl implements MovementRepository {
  final MovementRemoteDataSource _source;

  MovementRepositoryImpl(this._source);

  @override
  Future<Either<Failure, String>> createMovement(Movement params) async {
    try {
      final response = await _source.createMovement(
        MovementModel.fromEntity(params),
      );
      return Right(response);
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }
}

import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/preparation/preparation.dart';
import 'package:dartz/dartz.dart';

abstract class PreparationRepository {
  Future<Either<Failure, List<Preparation>>> findAllPreparation();
  Future<Either<Failure, Preparation>> findPreparationById({required int id});
  Future<Either<Failure, Preparation>> createPreparation({
    required Preparation params,
  });
  Future<Either<Failure, Preparation>> updateStatusPreparation({
    required int id,
    required String status,
    int? totalBox,
    int? locationId,
    String? remarks,
  });
  Future<Either<Failure, List<Preparation>>>
  findPreparationByCodeOrDestination({required String params});
}

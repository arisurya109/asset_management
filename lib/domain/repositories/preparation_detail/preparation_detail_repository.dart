import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/preparation_detail/preparation_detail.dart';
import 'package:dartz/dartz.dart';

abstract class PreparationDetailRepository {
  Future<Either<Failure, PreparationDetail>> createPreparationDetail({
    required PreparationDetail params,
  });
  Future<Either<Failure, List<PreparationDetail>>>
  findAllPreparationDetailByPreparationId({required int id});
  Future<Either<Failure, PreparationDetail>> findPreparationDetailById({
    required int id,
  });
  Future<Either<Failure, PreparationDetail>> updatePreparationDetail({
    required PreparationDetail params,
  });
  Future<Either<Failure, PreparationDetail>> updateStatusPreparationDetail({
    required int id,
    required String params,
  });
}

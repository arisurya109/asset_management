import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/preparation/preparation.dart';
import 'package:asset_management/domain/entities/preparation/preparation_pagination.dart';
import 'package:dartz/dartz.dart';

abstract class PreparationRepository {
  Future<Either<Failure, List<String>>> getPreparationTypes();
  Future<Either<Failure, Preparation>> createPreparation({
    required Preparation params,
  });
  Future<Either<Failure, PreparationPagination>> findPreparationByPagination({
    required int page,
    required int limit,
    String? query,
  });
  Future<Either<Failure, Preparation>> updatePreparationStatus({
    required int id,
    required String params,
    int? totalBox,
    int? temporaryLocationId,
  });
}

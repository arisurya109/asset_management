import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/preparation/preparation.dart';
import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';

abstract class PreparationRepository {
  Future<Either<Failure, List<Preparation>>> findAllPreparation();
  Future<Either<Failure, Preparation>> findPreparationById({required int id});
  Future<Either<Failure, Preparation>> createPreparation({
    required Preparation params,
  });
  Future<Either<Failure, Preparation>> updateStatusPreparation({
    required int id,
    required String params,
    int? locationId,
    int? totalBox,
  });
  Future<Either<Failure, Preparation>> completedPreparation({
    required int id,
    required PlatformFile file,
  });
}

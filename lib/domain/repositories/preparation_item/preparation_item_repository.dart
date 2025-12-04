import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/preparation_item/preparation_item.dart';
import 'package:dartz/dartz.dart';

abstract class PreparationItemRepository {
  Future<Either<Failure, PreparationItem>> createPreparationItem({
    required PreparationItem params,
  });
  Future<Either<Failure, List<PreparationItem>>>
  findAllPreparationItemByPreparationId({required int id});
  Future<Either<Failure, List<PreparationItem>>>
  findAllPreparationItemByPreparationDetailId({required int id});
  Future<Either<Failure, String>> deletePreparationItem({required int id});
}

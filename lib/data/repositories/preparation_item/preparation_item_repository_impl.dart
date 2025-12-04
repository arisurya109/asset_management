import 'package:asset_management/core/error/exception.dart';
import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/data/model/preparation_item/preparation_item_model.dart';
import 'package:asset_management/data/source/preparation_item/preparation_item_remote_data_source.dart';
import 'package:asset_management/domain/entities/preparation_item/preparation_item.dart';
import 'package:asset_management/domain/repositories/preparation_item/preparation_item_repository.dart';
import 'package:dartz/dartz.dart';

class PreparationItemRepositoryImpl implements PreparationItemRepository {
  final PreparationItemRemoteDataSource _source;

  PreparationItemRepositoryImpl(this._source);

  @override
  Future<Either<Failure, PreparationItem>> createPreparationItem({
    required PreparationItem params,
  }) async {
    try {
      final response = await _source.createPreparationItem(
        params: PreparationItemModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> deletePreparationItem({
    required int id,
  }) async {
    try {
      final response = await _source.deletePreparationItem(id: id);
      return Right(response);
    } on DeleteException catch (e) {
      return Left(DeleteFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<PreparationItem>>>
  findAllPreparationItemByPreparationDetailId({required int id}) async {
    try {
      final response = await _source
          .findAllPreparationItemByPreparationDetailId(id: id);
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<PreparationItem>>>
  findAllPreparationItemByPreparationId({required int id}) async {
    try {
      final response = await _source.findAllPreparationItemByPreparationId(
        id: id,
      );
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }
}

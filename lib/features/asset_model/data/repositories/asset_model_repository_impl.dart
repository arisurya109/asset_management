import 'package:asset_management/features/asset_model/data/model/asset_model_model.dart';
import 'package:asset_management/features/asset_model/data/source/asset_model_remote_data_source.dart';
import 'package:asset_management/features/asset_model/domain/entities/asset_model.dart';
import 'package:asset_management/features/asset_model/domain/repositories/asset_model_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';

class AssetModelRepositoryImpl implements AssetModelRepository {
  final AssetModelRemoteDataSource _source;

  AssetModelRepositoryImpl(this._source);

  @override
  Future<Either<Failure, AssetModel>> createAssetModel(
    AssetModel params,
  ) async {
    try {
      final response = await _source.createAssetModel(
        AssetModelModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<AssetModel>>> findAllAssetModel() async {
    try {
      final response = await _source.findAllAssetModel();
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }
}

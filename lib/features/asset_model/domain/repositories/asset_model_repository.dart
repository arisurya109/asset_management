import 'package:asset_management/core/core.dart';
import 'package:asset_management/features/asset_model/domain/entities/asset_model.dart';
import 'package:dartz/dartz.dart';

abstract class AssetModelRepository {
  Future<Either<Failure, List<AssetModel>>> findAllAssetModel();
  Future<Either<Failure, AssetModel>> createAssetModel(AssetModel params);
}

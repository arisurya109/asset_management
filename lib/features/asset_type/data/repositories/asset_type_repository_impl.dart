import 'package:asset_management/core/core.dart';
import 'package:asset_management/features/asset_type/data/model/asset_type_model.dart';
import 'package:asset_management/features/asset_type/data/source/asset_type_remote_data_source.dart';
import 'package:asset_management/features/asset_type/domain/entities/asset_type.dart';
import 'package:asset_management/features/asset_type/domain/repositories/asset_type_repository.dart';
import 'package:dartz/dartz.dart';

class AssetTypeRepositoryImpl implements AssetTypeRepository {
  final AssetTypeRemoteDataSource _source;

  AssetTypeRepositoryImpl(this._source);

  @override
  Future<Either<Failure, AssetType>> createAssetType(AssetType params) async {
    try {
      final response = await _source.createAssetType(
        AssetTypeModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<AssetType>>> findAllAssetType() async {
    try {
      final response = await _source.findAllAssetType();
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }
}

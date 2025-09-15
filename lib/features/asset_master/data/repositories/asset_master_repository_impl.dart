import '../model/asset_master_model.dart';
import '../source/asset_master_source.dart';
import '../../domain/entities/asset_master.dart';
import '../../domain/repositories/asset_master_repository.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';

import 'package:dartz/dartz.dart';

class AssetMasterRepositoryImpl implements AssetMasterRepository {
  final AssetMasterSource _source;

  AssetMasterRepositoryImpl(this._source);

  @override
  Future<Either<Failure, List<AssetMaster>>> findAllAssetMaster() async {
    try {
      final response = await _source.findAllAssetMaster();
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AssetMaster>> insertAssetMaster(
    AssetMaster params,
  ) async {
    try {
      final response = await _source.insertAssetMaster(
        AssetMasterModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AssetMaster>> updateAssetMaster(
    AssetMaster params,
  ) async {
    try {
      final response = await _source.updateAssetMaster(
        AssetMasterModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }
}

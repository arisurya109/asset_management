import 'package:asset_management/core/core.dart';
import 'package:asset_management/features/modules/asset_transfer/data/model/asset_transfer_model.dart';
import 'package:asset_management/features/modules/asset_transfer/data/source/asset_transfer_remote_data_source.dart';
import 'package:asset_management/features/modules/asset_transfer/domain/entities/asset_transfer.dart';
import 'package:asset_management/features/modules/asset_transfer/domain/repositories/asset_transfer_repository.dart';
import 'package:dartz/dartz.dart';

class AssetTransferRepositoryImpl implements AssetTransferRepository {
  final AssetTransferRemoteDataSource _source;

  AssetTransferRepositoryImpl(this._source);

  @override
  Future<Either<Failure, String>> createAssetTransfer(
    AssetTransfer params,
  ) async {
    try {
      final response = await _source.createAssetTransfer(
        AssetTransferModel.fromEntity(params),
      );
      return Right(response);
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }
}

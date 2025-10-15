import 'package:asset_management/core/core.dart';
import 'package:asset_management/features/modules/asset_transfer/domain/entities/asset_transfer.dart';
import 'package:dartz/dartz.dart';

abstract class AssetTransferRepository {
  Future<Either<Failure, String>> createAssetTransfer(AssetTransfer params);
}

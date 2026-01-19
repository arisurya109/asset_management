import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/domain/entities/picking/picking.dart';
import 'package:asset_management/domain/entities/picking/picking_detail_response.dart';
import 'package:asset_management/domain/entities/picking/picking_request.dart';
import 'package:dartz/dartz.dart';

abstract class PickingRepository {
  Future<Either<Failure, List<Picking>>> findAllPickingTask();
  Future<Either<Failure, PickingDetailResponse>> pickingDetailById({
    required int params,
  });
  Future<Either<Failure, String>> addPickAssetPicking({
    required PickingRequest params,
  });
  Future<Either<Failure, String>> updateStatusPicking({
    required PickingRequest params,
  });
}

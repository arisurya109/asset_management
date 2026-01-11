import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/domain/entities/picking/picking.dart';
import 'package:asset_management/domain/entities/picking/picking_detail_item.dart';
import 'package:asset_management/domain/entities/picking/picking_detail_response.dart';
import 'package:dartz/dartz.dart';

abstract class PickingRepository {
  Future<Either<Failure, List<Picking>>> findAllPickingTask();
  Future<Either<Failure, PickingDetailResponse>> findPickingDetail({
    required int id,
  });
  Future<Either<Failure, String>> pickedAsset({
    required int isConsumable,
    required PickingDetailItem params,
  });
  Future<Either<Failure, String>> updateStatusPicking({
    required int id,
    required String params,
    int? temporaryLocationId,
  });
}

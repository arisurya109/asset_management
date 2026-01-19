import 'package:asset_management/data/model/picking/picking_detail_response_model.dart';
import 'package:asset_management/data/model/picking/picking_model.dart';
import 'package:asset_management/domain/entities/picking/picking_request.dart';

abstract class PickingRemoteDataSource {
  Future<List<PickingModel>> findAllPickingTask();
  Future<PickingDetailResponseModel> pickingDetailById({required int params});
  Future<String> addPickAssetPicking({required PickingRequest params});
  Future<String> updateStatusPicking({required PickingRequest params});
}

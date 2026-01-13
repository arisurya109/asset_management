import 'package:asset_management/data/model/picking/picking_detail_model.dart';
import 'package:asset_management/data/model/picking/picking_detail_response_model.dart';
import 'package:asset_management/data/model/picking/picking_model.dart';

abstract class PickingRemoteDataSource {
  Future<List<PickingModel>> findAllPickingTask();
  Future<PickingDetailResponseModel> findPickingDetail({required int id});
  Future<String> pickedAsset({required PickingDetailModel params});
  Future<String> updateStatusPicking({
    required int id,
    required String params,
    int? temporaryLocationId,
    int? totalBox,
  });
}

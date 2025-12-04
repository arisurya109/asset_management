import 'package:asset_management/data/model/preparation_item/preparation_item_model.dart';

abstract class PreparationItemRemoteDataSource {
  Future<PreparationItemModel> createPreparationItem({
    required PreparationItemModel params,
  });
  Future<List<PreparationItemModel>> findAllPreparationItemByPreparationId({
    required int id,
  });
  Future<List<PreparationItemModel>>
  findAllPreparationItemByPreparationDetailId({required int id});
  Future<String> deletePreparationItem({required int id});
}

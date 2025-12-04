import 'package:asset_management/data/model/preparation_detail/preparation_detail_model.dart';

abstract class PreparationDetailRemoteDataSource {
  Future<List<PreparationDetailModel>> findAllPreparationDetailByPreparationId({
    required int id,
  });
  Future<PreparationDetailModel> findPreparationDetailById({required int id});
  Future<PreparationDetailModel> createPreparationDetail({
    required PreparationDetailModel params,
  });
  Future<PreparationDetailModel> updatePreparationDetail({
    required PreparationDetailModel params,
  });
  Future<PreparationDetailModel> updateStatusPreparationDetail({
    required int id,
    required String params,
  });
}

import 'package:asset_management/data/model/preparation/preparation_model.dart';

abstract class PreparationRemoteDataSource {
  Future<List<PreparationModel>> findAllPreparation();
  Future<PreparationModel> findPreparationById({required int id});
  Future<PreparationModel> createPreparation({
    required PreparationModel params,
  });
  Future<PreparationModel> updateStatusPreparation({
    required int id,
    required String status,
    int? totalBox,
    int? locationId,
    String? remarks,
  });
  Future<List<PreparationModel>> findPreparationByCodeOrDestination({
    required String params,
  });
}

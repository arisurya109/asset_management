import 'package:asset_management/data/model/preparation/preparation_model.dart';
import 'package:file_picker/file_picker.dart';

abstract class PreparationRemoteDataSource {
  Future<List<PreparationModel>> findAllPreparation();
  Future<PreparationModel> findPreparationById({required int id});
  Future<PreparationModel> updateStatusPreparation({
    required int id,
    required String params,
    int? locationId,
    int? totalBox,
  });
  Future<PreparationModel> createPreparation({
    required PreparationModel params,
  });
  Future<PreparationModel> completedPreparation({
    required int id,
    required PlatformFile file,
  });
}

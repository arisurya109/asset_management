import 'dart:io';

import 'package:asset_management/data/model/preparation/preparation_detail_model.dart';
import 'package:asset_management/data/model/preparation/preparation_item_model.dart';
import 'package:asset_management/data/model/preparation/preparation_model.dart';
import 'package:file_picker/file_picker.dart';

abstract class PreparationRemoteDataSource {
  // Preparation
  Future<List<PreparationModel>> findAllPreparation();
  Future<PreparationModel> findPreparationById(int params);
  Future<PreparationModel> createPreparation(PreparationModel params);
  Future<PreparationModel> updatePreparation(PreparationModel params);
  Future<PreparationModel> dispatchPreparation(PreparationModel params);
  Future<PreparationModel> completedPreparation(
    PlatformFile file,
    PreparationModel params,
  );
  Future<File> getDocumentPreparationById(int params);

  // PreparationDetail
  Future<List<PreparationDetailModel>> findAllPreparationDetailByPreparationId(
    int params,
  );
  Future<PreparationDetailModel> findPreparationDetailById(
    int params,
    int preparationId,
  );
  Future<PreparationDetailModel> createPreparationDetail(
    PreparationDetailModel params,
  );
  Future<PreparationDetailModel> updatePreparationDetail(
    PreparationDetailModel params,
  );

  // Preparation Item
  Future<PreparationItemModel> createPreparationItem(
    PreparationItemModel params,
  );
  Future<List<PreparationItemModel>>
  findAllPreparationItemByPreparationDetailId(int params, int preparationId);
  Future<List<PreparationItemModel>> findAllPreparationItemByPreparationId(
    int params,
  );
}

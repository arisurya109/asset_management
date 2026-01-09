// ignore_for_file: public_member_api_docs

import 'package:asset_management/data/model/preparation/preparation_detail_model.dart';
import 'package:asset_management/data/model/preparation/preparation_detail_response_model.dart';

abstract class PreparationDetailRemoteDataSource {
  Future<PreparationDetailResponseModel> getPreparationDetails({
    required int preparationId,
  });
  Future<String> addPreparationDetail({required PreparationDetailModel params});
}
